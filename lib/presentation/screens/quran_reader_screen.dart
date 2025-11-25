import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/services/quran_service.dart';
import '../../core/services/audio_service.dart';
import '../../core/providers/user_progress_provider.dart';
import '../../core/providers/bookmark_provider.dart';
import '../../core/models/bookmark_model.dart';
import '../../core/models/ayah_model.dart';
import '../widgets/flipbook_view.dart';
import '../theme/app_theme.dart';
import 'surah_list_screen.dart';
import '../../core/l10n/app_strings.dart';

import '../../core/providers/language_provider.dart';

class QuranReaderScreen extends StatefulWidget {
  final int? surahNumber;
  final int? initialAyah;

  const QuranReaderScreen({
    super.key,
    this.surahNumber,
    this.initialAyah,
  });

  @override
  State<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen> {
  final QuranService _quranService = QuranService();
  final AudioPlayerService _audioService = AudioPlayerService();
  late int _currentSurah;
  late int _currentAyah;
  bool _showTranslation = false;
  bool _autoPlay = true;
  bool _isAudioEnabled = false;
  bool _isPlaying = false;
  bool _isDisposing = false;
  FlipBookController? _flipBookController;
  List<AyahModel>? _ayahs;
  String? _currentLanguage; // Track current language to detect changes

  @override
  void initState() {
    super.initState();
    _currentSurah = widget.surahNumber ?? 1;
    _currentAyah = widget.initialAyah ?? 1;
    _flipBookController = FlipBookController();

    _audioService.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });

    // Listen to audio index changes to sync UI
    _audioService.player.currentIndexStream.listen((index) {
      if (mounted && index != null) {
        final newAyah = index + 1;

        // Only react if audio index is different from current UI (meaning audio moved ahead)
        if (_currentAyah != newAyah) {
          if (_autoPlay) {
            // Auto-play ON: Sync UI with Audio
            _flipBookController?.goToPage(index);
            setState(() {
              _currentAyah = newAyah;
            });
          } else {
            // Auto-play OFF: Pause Audio and stay on current page
            _audioService.pause();
          }
        }
      }
    });
  }

  void _initializeData(String languageCode) {
    final translationCode = languageCode == 'en' ? 'en' : 'id';
    _ayahs =
        _quranService.getSurah(_currentSurah, translationCode: translationCode);

    // Initialize playlist
    final surahInfo = _quranService.getSurahInfo(_currentSurah);
    final totalAyahs = surahInfo['verseCount'] as int;
    _audioService.initSurahPlaylist(_currentSurah, totalAyahs).catchError((e) {
      debugPrint('Error initializing playlist: $e');
    });
  }

  @override
  void dispose() {
    _isDisposing = true;
    _audioService.stop();
    super.dispose();
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currentAyah = index + 1;
    });

    if (_isAudioEnabled) {
      // Check if audio is already playing the correct track to avoid infinite loop
      // (UI update -> audio seek -> UI update)
      final currentAudioIndex = _audioService.player.currentIndex;

      // Play if:
      // 1. Audio is at a different track (need to seek)
      // OR
      // 2. Audio is at the correct track but PAUSED (need to resume/replay)
      if (currentAudioIndex != index || !_isPlaying) {
        // Auto-play next ayah if Audio Mode is enabled
        _audioService.playAyah(_currentSurah, _currentAyah).catchError((e) {
          if (mounted && !_isDisposing) {
            final errorMessage = e.toString();
            // Ignore "Loading interrupted" error which happens when stopping audio while loading
            if (!errorMessage.contains('Loading interrupted')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal memutar audio: $e')),
              );
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageCode =
        Provider.of<LanguageProvider>(context).currentLocale.languageCode;

    // Reload ayahs when language changes or on first load
    if (_ayahs == null ||
        _flipBookController == null ||
        _currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      _initializeData(languageCode);
    }

    final surahInfo = _quranService.getSurahInfo(_currentSurah);
    final totalAyahs = surahInfo['verseCount'] as int;
    final ayahs = _ayahs!;
    final flipBookController = _flipBookController!;

    return Scaffold(
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
        titleSpacing: 0,
        title: const SizedBox.shrink(),
        actions: [
          Consumer<BookmarkProvider>(
            builder: (context, bookmarkProvider, child) {
              final isBookmarked =
                  bookmarkProvider.isBookmarked(_currentSurah, _currentAyah);
              return IconButton(
                icon: Icon(
                  isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: Colors.white,
                ),
                iconSize: 22,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                constraints: const BoxConstraints(),
                onPressed: () {
                  final ayah =
                      _quranService.getAyah(_currentSurah, _currentAyah);
                  if (isBookmarked) {
                    bookmarkProvider.removeBookmark(
                        _currentSurah, _currentAyah);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text(AppStrings.get(context, 'bookmarkRemoved'))),
                    );
                  } else {
                    bookmarkProvider.addBookmark(BookmarkModel(
                      surahNumber: _currentSurah,
                      ayahNumber: _currentAyah,
                      surahName: ayah.surahName,
                      surahNameArabic: ayah.surahNameArabic,
                      createdAt: DateTime.now(),
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text(AppStrings.get(context, 'bookmarkAdded'))),
                    );
                  }
                },
                tooltip: isBookmarked
                    ? AppStrings.get(context, 'bookmarkRemoved')
                    : AppStrings.get(context, 'bookmarkAdded'),
              );
            },
          ),
          IconButton(
            icon: Icon(
              _showTranslation
                  ? Icons.translate_rounded
                  : Icons.translate_outlined,
              color: Colors.white,
            ),
            iconSize: 22,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _showTranslation = !_showTranslation;
              });
            },
            tooltip: AppStrings.get(context, 'translation'),
          ),
          IconButton(
            icon: Icon(
              _autoPlay ? Icons.autorenew_rounded : Icons.highlight_off_rounded,
              color: Colors.white,
            ),
            iconSize: 22,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _autoPlay = !_autoPlay;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      _autoPlay ? 'Auto-Play Aktif' : 'Auto-Play Non-Aktif'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            tooltip: _autoPlay ? 'Matikan Auto-Play' : 'Aktifkan Auto-Play',
          ),
          IconButton(
            icon: const Icon(
              Icons.list_rounded,
              color: Colors.white,
            ),
            iconSize: 22,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            constraints: const BoxConstraints(),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SurahListScreen(),
                ),
              );
            },
            tooltip: 'Daftar Surah',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: _currentAyah / totalAyahs,
                        minHeight: 10,
                        backgroundColor:
                            AppTheme.primaryGreen.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryGreen),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      '$_currentAyah / $totalAyahs',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Flipbook view
            Expanded(
              child: FlipBookView(
                key: ValueKey('flipbook_$_currentSurah'),
                ayahs: ayahs,
                initialIndex: _currentAyah - 1,
                onPageChanged: _handlePageChanged,
                showTranslation: _showTranslation,
                controller: flipBookController,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              AppTheme.primaryGreen.withValues(alpha: 0.05),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: _currentAyah > 1
                    ? () {
                        flipBookController.previousPage();
                      }
                    : null,
                tooltip: 'Ayat Sebelumnya',
                color:
                    _currentAyah > 1 ? AppTheme.primaryGreen : Colors.grey[400],
                iconSize: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(_isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded),
                  iconSize: 32,
                  onPressed: () async {
                    if (!mounted) return;
                    final messenger = ScaffoldMessenger.of(context);
                    try {
                      if (_isPlaying) {
                        setState(() {
                          _isAudioEnabled = false;
                        });
                        await _audioService.pause();
                      } else {
                        setState(() {
                          _isAudioEnabled = true;
                        });
                        await _audioService.playAyah(
                            _currentSurah, _currentAyah);
                      }
                    } catch (e) {
                      if (!mounted) return;
                      messenger.showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  },
                  tooltip: _isPlaying ? 'Jeda Audio' : 'Putar Audio',
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  final ayah =
                      _quranService.getAyah(_currentSurah, _currentAyah);
                  final letterCount =
                      _quranService.countHijaiyahLetters(ayah.arabicText);
                  final points = letterCount * 10;

                  final progressProvider =
                      Provider.of<UserProgressProvider>(context, listen: false);
                  progressProvider.addAyahRead(points);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '+$points Pahala! ($letterCount Huruf x 10)',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: AppTheme.lightGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_rounded),
                label: Text(
                  'Tandai Dibaca',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: AppTheme.primaryGreen.withValues(alpha: 0.4),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                onPressed: _currentAyah < totalAyahs
                    ? () {
                        flipBookController.nextPage();
                      }
                    : null,
                tooltip: 'Ayat Selanjutnya',
                color: _currentAyah < totalAyahs
                    ? AppTheme.primaryGreen
                    : Colors.grey[400],
                iconSize: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
