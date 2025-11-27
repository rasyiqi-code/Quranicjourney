import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:marquee/marquee.dart';
import '../theme/app_theme.dart';
import '../../core/providers/language_provider.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/services/quran_service.dart';
import '../widgets/reward_info_dialog.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late String _motivationalMessage;

  final List<Map<String, int>> _inspirationalVerses = [
    {'surah': 2, 'ayah': 153}, // Al-Baqarah: 153 (Patience and Prayer)
    {'surah': 2, 'ayah': 286}, // Al-Baqarah: 286 (No burden more than bearable)
    {'surah': 3, 'ayah': 139}, // Ali 'Imran: 139 (Do not weaken)
    {'surah': 65, 'ayah': 2}, // At-Talaq: 2 (Way out)
    {'surah': 65, 'ayah': 3}, // At-Talaq: 3 (Sufficient is Allah)
    {'surah': 94, 'ayah': 5}, // Ash-Sharh: 5 (With hardship comes ease)
    {'surah': 94, 'ayah': 6}, // Ash-Sharh: 6 (With hardship comes ease)
    {'surah': 29, 'ayah': 69}, // Al-Ankabut: 69 (Guidance for strivers)
    {'surah': 40, 'ayah': 60}, // Ghafir: 60 (Call upon Me)
    {'surah': 39, 'ayah': 53}, // Az-Zumar: 53 (Do not despair)
  ];

  @override
  void initState() {
    super.initState();
    // Start with default message
    _motivationalMessage = '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateMotivationalMessage();
  }

  void _updateMotivationalMessage() async {
    final languageCode = Provider.of<LanguageProvider>(context, listen: false)
        .currentLocale
        .languageCode;
    final random = Random();
    final verse =
        _inspirationalVerses[random.nextInt(_inspirationalVerses.length)];

    try {
      final ayah = await QuranService().getAyah(verse['surah']!, verse['ayah']!,
          translationCode: languageCode);

      if (mounted) {
        setState(() {
          _motivationalMessage =
              '"${ayah.translation}" (QS. ${ayah.surahName}: ${ayah.ayahNumber})';
        });
      }
    } catch (e) {
      // If loading fails, show a default message
      if (mounted) {
        setState(() {
          _motivationalMessage = 'Loading inspirational verse...';
        });
      }
    }
  }

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return AppStrings.get(context, 'greetingMorning');
    } else if (hour < 17) {
      return AppStrings.get(context, 'greetingAfternoon');
    } else if (hour < 20) {
      return AppStrings.get(context, 'greetingEvening');
    } else {
      return AppStrings.get(context, 'greetingNight');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.gradientDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: 24,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.wb_sunny,
                  color: Colors.white,
                  size: 24,
                ),
              ).animate().fadeIn(duration: 400.ms).scale(
                  begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assalamu\'alaikum',
                      style: GoogleFonts.poppins(
                        fontSize: 14, // Reduced from 16
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                        height: 1.0, // Compact height
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 100.ms)
                        .slideX(begin: -0.2, end: 0),
                    const SizedBox(height: 2), // Small gap
                    Text(
                      _getGreeting(context),
                      style: GoogleFonts.poppins(
                        fontSize: 20, // Reduced from 24
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.1, // Compact height
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .slideX(begin: -0.2, end: 0),
                  ],
                ),
              ),
              // Info Button for Reward Information
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.info_outline,
                      color: Colors.white, size: 20),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const RewardInfoDialog(),
                    );
                  },
                  tooltip: 'Tentang Pahala',
                ),
              ).animate().fadeIn(duration: 400.ms).scale(
                  begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
              // Language Selector
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.language_rounded,
                      color: Colors.white, size: 20),
                  onSelected: (String code) {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLanguage(code);
                    // Message will update automatically via didChangeDependencies when provider notifies
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'id',
                      child: Text('Bahasa Indonesia'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'en',
                      child: Text('English'),
                    ),
                  ],
                  tooltip: AppStrings.get(context, 'language'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ).animate().fadeIn(duration: 400.ms).scale(
                  begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppTheme.goldAccent,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: _motivationalMessage.isEmpty
                        ? const SizedBox()
                        : Marquee(
                            text: _motivationalMessage,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.95),
                              fontStyle: FontStyle.italic,
                            ),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            blankSpace: 20.0,
                            velocity: 30.0,
                            pauseAfterRound: const Duration(seconds: 3),
                            startPadding: 10.0,
                            accelerationDuration: const Duration(seconds: 1),
                            accelerationCurve: Curves.linear,
                            decelerationDuration:
                                const Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                          ),
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 300.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.1, end: 0);
  }
}
