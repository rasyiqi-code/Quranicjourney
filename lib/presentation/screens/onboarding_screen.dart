import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/providers/onboarding_provider.dart';
import '../../core/providers/language_provider.dart';
import '../widgets/onboarding_page.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Localized content generator
  List<Map<String, dynamic>> _getPages(String languageCode) {
    final isId = languageCode == 'id';
    return [
      {
        'image': '📖',
        'title': isId
            ? 'Selamat Datang di\nQuranic Journey'
            : 'Welcome to\nQuranic Journey',
        'description': isId
            ? 'Mulai perjalanan spiritual Anda dengan pembelajaran Al-Qur\'an yang personal dan menyenangkan'
            : 'Start your spiritual journey with personalized and enjoyable Quran learning',
        'color': AppTheme.primaryGreen,
      },
      {
        'image': '💭',
        'title': isId
            ? 'Tadabbur Mode &\nRefleksi Mendalam'
            : 'Tadabbur Mode &\nDeep Reflection',
        'description': isId
            ? 'Renungkan makna ayat-ayat Al-Qur\'an dengan panduan AI dan kisah-kisah inspiratif'
            : 'Reflect on the meanings of Quranic verses with AI guidance and inspiring stories',
        'color': AppTheme.darkGreen,
      },
      {
        'image': '🏆',
        'title':
            isId ? 'Gamifikasi &\nPencapaian' : 'Gamification &\nAchievements',
        'description': isId
            ? 'Raih poin, badge, dan streak untuk memotivasi konsistensi belajar Anda setiap hari'
            : 'Earn points, badges, and streaks to motivate your daily learning consistency',
        'color': AppTheme.accentGreen,
      },
    ];
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _skipOnboarding() {
    final onboardingProvider = context.read<OnboardingProvider>();
    onboardingProvider.completeOnboarding();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _nextPage() {
    final pages =
        _getPages(context.read<LanguageProvider>().currentLocale.languageCode);
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skipOnboarding();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final pages = _getPages(languageProvider.currentLocale.languageCode);
    final isId = languageProvider.currentLocale.languageCode == 'id';

    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              return OnboardingPage(
                image: page['image'],
                title: page['title'],
                description: page['description'],
                backgroundColor: page['color'],
              );
            },
          ),

          // Skip Button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _skipOnboarding,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                isId ? 'Lewati' : 'Skip',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ).animate().fadeIn(duration: 300.ms),

          // Language Toggle
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(Icons.language, color: Colors.white),
                onPressed: () {
                  final newLang = isId ? 'en' : 'id';
                  languageProvider.setLanguage(newLang);
                },
                tooltip: isId ? 'Ganti Bahasa' : 'Change Language',
              ),
            ),
          ).animate().fadeIn(duration: 300.ms),

          // Bottom Section with Indicators and Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Next/Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.goldAccent,
                        foregroundColor: AppTheme.primaryGreen,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentPage == pages.length - 1
                            ? (isId ? 'Mulai Sekarang' : 'Get Started')
                            : (isId ? 'Lanjut' : 'Next'),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().slideY(begin: 0.3, duration: 400.ms),
        ],
      ),
    );
  }
}
