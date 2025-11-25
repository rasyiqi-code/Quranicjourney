import 'package:flutter/material.dart';

/// Model untuk nominal donasi
class DonationTier {
  final String id;
  final String name;
  final String description;
  final bool isSubscription;
  final IconData icon;
  final List<Color> gradientColors;

  const DonationTier({
    required this.id,
    required this.name,
    required this.description,
    required this.isSubscription,
    required this.icon,
    required this.gradientColors,
  });

  /// Daftar produk donasi yang tersedia
  static final List<DonationTier> tiers = [
    DonationTier(
      id: 'remove_ads', // One-time donation
      name: 'One Time Donation',
      description: 'Donate once to remove ads forever',
      isSubscription: false,
      icon: Icons.volunteer_activism,
      gradientColors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
    ),
    DonationTier(
      id: 'sub_donate_removeads', // Monthly subscription
      name: 'Monthly Donation',
      description: 'Support us monthly & remove ads',
      isSubscription: true,
      icon: Icons.favorite,
      gradientColors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    ),
  ];
}
