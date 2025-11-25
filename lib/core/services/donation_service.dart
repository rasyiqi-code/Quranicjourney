import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/donation_tier.dart';

/// Service untuk menangani donasi dengan In-App Purchase
class DonationService {
  static final DonationService _instance = DonationService._internal();
  factory DonationService() => _instance;
  DonationService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];
  bool _isAvailable = false;

  /// Initialize IAP connection
  Future<void> initialize() async {
    // Check if IAP is available
    _isAvailable = await _iap.isAvailable();

    if (!_isAvailable) {
      return;
    }

    // Listen to purchase updates
    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _onPurchaseDone,
      onError: _onPurchaseError,
    );

    // Load products from store
    await _loadProducts();
  }

  /// Load products from Google Play Store
  Future<void> _loadProducts() async {
    final Set<String> productIds =
        DonationTier.tiers.map((tier) => tier.id).toSet();

    final ProductDetailsResponse response =
        await _iap.queryProductDetails(productIds);

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('IAP: Products not found: ${response.notFoundIDs}');
    }

    _products = response.productDetails;
  }

  /// Mendapatkan semua tier donasi
  List<DonationTier> getTiers() {
    return DonationTier.tiers;
  }

  /// Check if IAP is available
  bool get isAvailable => _isAvailable;

  /// Get product details for a tier
  ProductDetails? getProductDetails(String productId) {
    try {
      return _products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  /// Process donation menggunakan In-App Purchase
  /// Returns true jika purchase initiated successfully
  Future<bool> processDonation(DonationTier tier) async {
    if (!_isAvailable) {
      debugPrint('IAP: Not available');
      return false;
    }

    final ProductDetails? productDetails = getProductDetails(tier.id);

    if (productDetails == null) {
      debugPrint('IAP: Product not found: ${tier.id}');
      return false;
    }

    // Create purchase param for consumable (donation)
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );

    try {
      // Use buyNonConsumable for both One-Time (Managed) and Subscription products
      // buyConsumable is only for products that can be bought multiple times (e.g. coins)
      final bool success = await _iap.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      return success;
    } catch (e) {
      debugPrint('IAP: Error purchasing: $e');
      return false;
    }
  }

  /// Handle purchase updates
  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show pending UI
        debugPrint('IAP: Purchase pending: ${purchaseDetails.productID}');
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle error
        debugPrint('IAP: Purchase error: ${purchaseDetails.error}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        // Verify and deliver product
        _verifyAndDeliverProduct(purchaseDetails);
      }

      // Mark purchase as done (required for both Consumables and Non-Consumables)
      // This acknowledges the purchase on Android
      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  /// Verify and deliver purchased product
  Future<void> _verifyAndDeliverProduct(PurchaseDetails purchaseDetails) async {
    // NOTE: In production, verify purchase with your backend server
    // to prevent fraud. See: https://developer.android.com/google/play/billing/security
    // For now, we save to local history without server verification
    final tier = getTierById(purchaseDetails.productID);
    if (tier != null) {
      await saveDonationHistory(tier);
    }

    debugPrint('IAP: Purchase verified: ${purchaseDetails.productID}');
  }

  /// Handle purchase stream done
  void _onPurchaseDone() {
    debugPrint('IAP: Purchase stream done');
  }

  /// Handle purchase stream error
  void _onPurchaseError(dynamic error) {
    debugPrint('IAP: Purchase stream error: $error');
  }

  /// Mendapatkan tier berdasarkan ID
  DonationTier? getTierById(String id) {
    try {
      return DonationTier.tiers.firstWhere((tier) => tier.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Save donation history
  Future<void> saveDonationHistory(DonationTier tier) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> history =
          prefs.getStringList('donation_history') ?? [];

      // Store donation record in simple format: "id|name|timestamp"
      history
          .add('${tier.id}|${tier.name}|${DateTime.now().toIso8601String()}');

      await prefs.setStringList('donation_history', history);
      debugPrint('IAP: Donation saved: ${tier.name}');
    } catch (e) {
      debugPrint('IAP: Error saving donation history: $e');
    }
  }

  /// Dispose and clean up
  void dispose() {
    _subscription?.cancel();
  }
}
