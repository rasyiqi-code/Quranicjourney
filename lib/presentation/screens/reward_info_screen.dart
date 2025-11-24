import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/data/reward_info_data.dart';
import '../../core/providers/language_provider.dart';

class RewardInfoScreen extends StatelessWidget {
  const RewardInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final rewardInfo = RewardInfoData.getByLanguage(
      languageProvider.currentLocale.languageCode,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF006064),
              const Color(0xFF00838F),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Icon
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.info_outline,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ).animate().scale(duration: 400.ms),
                      const SizedBox(height: 24),

                      // Title
                      Center(
                        child: Text(
                          rewardInfo.title,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ).animate().fadeIn(delay: 100.ms),
                      const SizedBox(height: 32),

                      // Simulasi Motivasi Card
                      _buildInfoCard(
                        icon: Icons.psychology_outlined,
                        title: rewardInfo.subtitle,
                        description: rewardInfo.description,
                        color: Colors.amber,
                      ).animate().slideX(begin: -0.2, delay: 200.ms),
                      const SizedBox(height: 16),

                      // Niat Ibadah Card
                      _buildInfoCard(
                        icon: Icons.favorite_border,
                        title: rewardInfo.niatTitle,
                        description: rewardInfo.niatDescription,
                        color: Colors.pink,
                      ).animate().slideX(begin: -0.2, delay: 300.ms),
                      const SizedBox(height: 16),

                      // Pahala Sesungguhnya Card
                      _buildInfoCard(
                        icon: Icons.star_border,
                        title: rewardInfo.pahalaTitle,
                        description: rewardInfo.pahalaDescription,
                        color: Colors.green,
                      ).animate().slideX(begin: -0.2, delay: 400.ms),
                      const SizedBox(height: 32),

                      // Bottom Note
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.amber[300],
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  languageProvider.currentLocale.languageCode ==
                                          'id'
                                      ? 'Ingat: Niat yang ikhlas adalah kunci utama'
                                      : 'Remember: Sincere intention is the main key',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF006064),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
