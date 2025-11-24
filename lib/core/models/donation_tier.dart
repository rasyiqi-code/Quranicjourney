import 'package:flutter/material.dart';

/// Model untuk nominal donasi
class DonationTier {
  final String id;
  final int amount; // dalam Rupiah
  final IconData icon;
  final List<Color> gradientColors;

  const DonationTier({
    required this.id,
    required this.amount,
    required this.icon,
    required this.gradientColors,
  });

  String get formattedAmount {
    return 'Rp ${amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }

  /// Daftar nominal donasi yang tersedia
  static final List<DonationTier> tiers = [
    DonationTier(
      id: 'donate_10k', // Product ID di Google Play Console
      amount: 10000,
      icon: Icons.favorite,
      gradientColors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
    ),
    DonationTier(
      id: 'donate_25k', // Product ID di Google Play Console
      amount: 25000,
      icon: Icons.favorite,
      gradientColors: [Color(0xFF00695C), Color(0xFF00897B)],
    ),
    DonationTier(
      id: 'donate_50k', // Product ID di Google Play Console
      amount: 50000,
      icon: Icons.favorite,
      gradientColors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    ),
    DonationTier(
      id: 'donate_100k', // Product ID di Google Play Console
      amount: 100000,
      icon: Icons.favorite,
      gradientColors: [Color(0xFFFFD700), Color(0xFFFFA000)],
    ),
  ];
}
