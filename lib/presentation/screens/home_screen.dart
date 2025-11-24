import 'package:flutter/material.dart';
import '../../core/l10n/app_strings.dart';
import 'tadabbur_screen.dart';
import 'funfact_list_screen.dart';
import 'quran_reader_screen.dart';
import 'surah_list_screen.dart';
import 'bookmark_list_screen.dart';
import 'search_screen.dart';
import 'donation_screen.dart';
import '../widgets/modern_progress_card.dart';
import '../widgets/modern_feature_card.dart';
import '../widgets/hero_section.dart';
import '../widgets/page_transition.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeroSection(),
                const SizedBox(height: 10),
                const ModernProgressCard(),
                const SizedBox(height: 10),
                _buildFeaturesSection(context),
                const SizedBox(height: 10),
                _buildDonationSection(context),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ModernFeatureCard(
                title: AppStrings.get(context, 'featureReadQuran'),
                icon: Icons.menu_book_rounded,
                color: const Color(0xFF2E7D32),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransitions.slideRoute(
                      const QuranReaderScreen(),
                    ),
                  );
                },
                delay: 0,
              ),
            ),
            Container(
              width: 1,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.withValues(alpha: 0),
                    Colors.grey.withValues(alpha: 0.3),
                    Colors.grey.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ModernFeatureCard(
                title: AppStrings.get(context, 'featureSurahList'),
                icon: Icons.list_rounded,
                color: const Color(0xFF00695C),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF00695C), Color(0xFF00897B)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransitions.slideRoute(
                      const SurahListScreen(),
                    ),
                  );
                },
                delay: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ModernFeatureCard(
                title: AppStrings.get(context, 'featureTadabbur'),
                icon: Icons.self_improvement_rounded,
                color: const Color(0xFF1565C0),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransitions.slideRoute(
                      const TadabburScreen(),
                    ),
                  );
                },
                delay: 2,
              ),
            ),
            Container(
              width: 1,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.withValues(alpha: 0),
                    Colors.grey.withValues(alpha: 0.3),
                    Colors.grey.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ModernFeatureCard(
                title: AppStrings.get(context, 'featureFunfact'),
                icon: Icons.lightbulb_rounded,
                color: const Color(0xFFE65100),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE65100), Color(0xFFFF9800)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransitions.slideRoute(
                      const FunfactListScreen(),
                    ),
                  );
                },
                delay: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ModernFeatureCard(
                title: AppStrings.get(context, 'featureSearch'),
                icon: Icons.search_rounded,
                color: const Color(0xFF6A1B9A),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6A1B9A), Color(0xFF9C27B0)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransitions.slideRoute(
                      const SearchScreen(),
                    ),
                  );
                },
                delay: 4,
              ),
            ),
            Container(
              width: 1,
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.withValues(alpha: 0),
                    Colors.grey.withValues(alpha: 0.3),
                    Colors.grey.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ModernFeatureCard(
                title: AppStrings.get(context, 'featureBookmark'),
                icon: Icons.bookmark_rounded,
                color: const Color(0xFFC62828),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFC62828), Color(0xFFEF5350)],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransitions.slideRoute(
                      const BookmarkListScreen(),
                    ),
                  );
                },
                delay: 5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDonationSection(BuildContext context) {
    return Container(
      decoration: AppTheme.glassmorphism(),
      child: InkWell(
        onTap: () => _showDonationDialog(context),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFA000).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.volunteer_activism_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.get(context, 'donation'),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.get(context, 'donationDesc'),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDonationDialog(BuildContext context) {
    Navigator.push(
      context,
      PageTransitions.slideRoute(
        const DonationScreen(),
      ),
    );
  }
}
