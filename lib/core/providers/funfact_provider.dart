import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/funfact_model.dart';
import '../services/funfact_service.dart';

class FunfactProvider with ChangeNotifier {
  final FunfactService _funfactService = FunfactService();
  final List<FunfactModel> _funfacts = [];
  List<FunfactModel> _filteredFunfacts = [];
  FunfactModel? _currentFunfact;
  String? _selectedCategory;
  String _searchQuery = '';
  bool _isLoading = false;
  String? _loadingMessage;

  List<FunfactModel> get funfacts =>
      _filteredFunfacts.isEmpty ? _funfacts : _filteredFunfacts;
  FunfactModel? get currentFunfact => _currentFunfact;
  FunfactModel? _dailyFunfact;
  FunfactModel? get dailyFunfact => _dailyFunfact;
  bool get isLoading => _isLoading;
  String? get loadingMessage => _loadingMessage;
  String? get selectedCategory => _selectedCategory;

  Future<void> generateFunfact({
    String category = 'funfact',
    String languageCode = 'id',
  }) async {
    _isLoading = true;
    _loadingMessage = languageCode == 'en'
        ? 'AI is creating an interesting fun fact...'
        : 'AI sedang membuat funfact menarik...';
    _currentFunfact = null;
    notifyListeners();

    try {
      _currentFunfact = await _funfactService
          .generateFunfact(category: category, languageCode: languageCode)
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException(languageCode == 'en'
              ? 'Request timeout after 60 seconds. Please try again.'
              : 'Request timeout setelah 60 detik. Silakan coba lagi.');
        },
      );

      if (_currentFunfact != null) {
        // Tambahkan ke list jika belum ada
        if (!_funfacts.any((f) => f.id == _currentFunfact!.id)) {
          _funfacts.insert(0, _currentFunfact!);
        }
        _applyFilters();
      }

      _isLoading = false;
      _loadingMessage = null;
    } catch (e, stackTrace) {
      debugPrint('Error generating funfact: $e');
      debugPrint('Stack trace: $stackTrace');
      _isLoading = false;

      String errorMessage = e.toString();
      errorMessage = errorMessage
          .replaceAll('Exception: ', '')
          .replaceAll('TimeoutException: ', '');

      if (errorMessage.length > 200) {
        errorMessage = '${errorMessage.substring(0, 197)}...';
      }

      _loadingMessage = errorMessage.isNotEmpty
          ? errorMessage
          : (languageCode == 'en'
              ? 'Failed to load funfact. Please try again.'
              : 'Gagal memuat funfact. Silakan coba lagi.');
      _currentFunfact = null;
    } finally {
      notifyListeners();
    }
  }

  // Load daily funfact (auto-generate jika belum ada)
  Future<void> loadDailyFunfact({String languageCode = 'id'}) async {
    _isLoading = true;
    _loadingMessage = languageCode == 'en'
        ? 'Loading daily funfact...'
        : 'Memuat funfact harian...';
    notifyListeners();

    try {
      _dailyFunfact = await _funfactService
          .getDailyFunfact(languageCode: languageCode)
          .timeout(
        const Duration(seconds: 90),
        onTimeout: () {
          throw TimeoutException(languageCode == 'en'
              ? 'Request timeout after 90 seconds. Please try again.'
              : 'Request timeout setelah 90 detik. Silakan coba lagi.');
        },
      );

      if (_dailyFunfact != null) {
        _currentFunfact = _dailyFunfact;
      }

      _isLoading = false;
      _loadingMessage = null;
    } catch (e, stackTrace) {
      debugPrint('Error loading daily funfact: $e');
      debugPrint('Stack trace: $stackTrace');
      _isLoading = false;

      String errorMessage = e.toString();
      errorMessage = errorMessage
          .replaceAll('Exception: ', '')
          .replaceAll('TimeoutException: ', '');

      if (errorMessage.length > 200) {
        errorMessage = '${errorMessage.substring(0, 197)}...';
      }

      _loadingMessage = errorMessage.isNotEmpty
          ? errorMessage
          : 'Gagal memuat funfact harian. Silakan coba lagi.';
      _dailyFunfact = null;
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadAllFunfacts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _funfacts.clear();
      final funfacts =
          await _funfactService.getAllFunfacts(category: _selectedCategory);
      _funfacts.addAll(funfacts);
      _applyFilters();
    } catch (e) {
      debugPrint('Error loading funfacts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void searchFunfacts(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredFunfacts = _funfacts;

    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      _filteredFunfacts = _filteredFunfacts
          .where((f) => f.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      _filteredFunfacts = _filteredFunfacts.where((f) {
        return f.title.toLowerCase().contains(lowerQuery) ||
            f.content.toLowerCase().contains(lowerQuery);
      }).toList();
    }
  }

  void resetCurrentFunfact() {
    _currentFunfact = null;
    _loadingMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  void setCurrentFunfact(FunfactModel funfact) {
    _currentFunfact = funfact;
    notifyListeners();
  }
}
