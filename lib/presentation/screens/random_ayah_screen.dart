import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/services/quran_service.dart';
import '../../core/providers/language_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/page_transition.dart';
import 'quran_reader_screen.dart';

class RandomAyahScreen extends StatefulWidget {
  const RandomAyahScreen({super.key});

  @override
  State<RandomAyahScreen> createState() => _RandomAyahScreenState();
}

class _RandomAyahScreenState extends State<RandomAyahScreen> {
  final QuranService _quranService = QuranService();
  int? _currentSurah;
  int? _currentAyah;
  String? _arabicText;
  String? _translation;
  String? _surahName;
  String? _surahNameArabic;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateRandomAyah();
    });
  }

  void _generateRandomAyah() {
    final languageCode = Provider.of<LanguageProvider>(context, listen: false)
        .currentLocale
        .languageCode;

    // Generate random surah (1-114)
    final randomSurah = _random.nextInt(114) + 1;
    final surahInfo = _quranService.getSurahInfo(randomSurah);
    final verseCount = surahInfo['verseCount'] as int;

    // Generate random ayah within that surah
    final randomAyah = _random.nextInt(verseCount) + 1;

    // Get the ayah details
    final translationCode = languageCode == 'en' ? 'en' : 'id';
    final ayah = _quranService.getAyah(
      randomSurah,
      randomAyah,
      translationCode: translationCode,
    );

    setState(() {
      _currentSurah = randomSurah;
      _currentAyah = randomAyah;
      _arabicText = ayah.arabicText;
      _translation = ayah.translation;
      _surahName = ayah.surahName;
      _surahNameArabic = ayah.surahNameArabic;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageCode =
        Provider.of<LanguageProvider>(context).currentLocale.languageCode;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryGreen,
                AppTheme.darkGreen,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 48,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          languageCode == 'en' ? 'Random Ayah' : 'Ayat Acak',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: _currentSurah == null
          ? Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryGreen,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Surah Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          _surahNameArabic ?? '',
                          style: GoogleFonts.amiriQuran(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$_surahName',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${languageCode == 'en' ? 'Verse' : 'Ayat'} $_currentAyah',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Arabic Text
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _arabicText ?? '',
                      style: GoogleFonts.amiriQuran(
                        fontSize: 28,
                        height: 2.0,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Translation
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _translation ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _generateRandomAyah,
                          icon: const Icon(Icons.refresh_rounded),
                          label: Text(
                            languageCode == 'en' ? 'New Verse' : 'Ayat Baru',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransitions.slideRoute(
                                QuranReaderScreen(
                                  surahNumber: _currentSurah!,
                                  initialAyah: _currentAyah!,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.menu_book_rounded),
                          label: Text(
                            languageCode == 'en' ? 'Read Surah' : 'Baca Surah',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryGreen,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(
                              color: AppTheme.primaryGreen,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
