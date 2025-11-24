import 'package:flutter/material.dart';
import 'flipbook_page.dart';
import '../../core/models/ayah_model.dart';

class FlipBookController {
  _FlipBookViewState? _state;

  void _attach(_FlipBookViewState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  void nextPage() {
    _state?._nextPage();
  }

  void previousPage() {
    _state?._previousPage();
  }

  void goToPage(int index) {
    _state?._goToPage(index);
  }

  int get currentPage => _state?._currentPage ?? 0;
}

class FlipBookView extends StatefulWidget {
  final List<AyahModel> ayahs;
  final int initialIndex;
  final Function(int)? onPageChanged;
  final bool showTranslation;
  final FlipBookController? controller;

  const FlipBookView({
    super.key,
    required this.ayahs,
    this.initialIndex = 0,
    this.onPageChanged,
    this.showTranslation = false,
    this.controller,
  });

  @override
  State<FlipBookView> createState() => _FlipBookViewState();
}

class _FlipBookViewState extends State<FlipBookView> {
  late PageController _pageController;
  late int _currentPage;
  Set<int> _showTranslationForAyah = <int>{};

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 0.95,
    );
    widget.controller?._attach(this);
    // Pastikan Set diinisialisasi dengan benar - reset untuk menghindari error hot reload
    _showTranslationForAyah = <int>{};
  }

  @override
  void didUpdateWidget(FlipBookView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset state saat widget diupdate untuk menghindari error hot reload
    _showTranslationForAyah = <int>{};
  }

  void _toggleTranslation(int ayahIndex) {
    setState(() {
      try {
        if (_showTranslationForAyah.contains(ayahIndex)) {
          _showTranslationForAyah.remove(ayahIndex);
        } else {
          _showTranslationForAyah.add(ayahIndex);
        }
      } catch (e) {
        // Jika terjadi error (misalnya dari hot reload), reset Set
        _showTranslationForAyah = <int>{};
        _showTranslationForAyah.add(ayahIndex);
      }
    });
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ayahs.isEmpty) {
      return const Center(
        child: Text('Tidak ada ayat untuk ditampilkan'),
      );
    }

    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
        widget.onPageChanged?.call(index);
      },
      itemCount: widget.ayahs.length,
      itemBuilder: (context, index) {
        final ayah = widget.ayahs[index];
        final pageValue = _pageController.hasClients
            ? (_pageController.page ?? index.toDouble())
            : index.toDouble();
        final difference = (pageValue - index).abs();

        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 0.0;
            if (_pageController.position.haveDimensions) {
              value = index.toDouble() - (_pageController.page ?? 0);
              value = (value * 0.5).clamp(-1.0, 1.0);
            }

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(value * 0.1),
              child: Opacity(
                opacity: (1 - difference * 0.5).clamp(0.3, 1.0),
                child: Transform.scale(
                  scale: (1 - difference * 0.1).clamp(0.85, 1.0),
                  child: FlipBookPage(
                    arabicText: ayah.arabicText,
                    translation: ayah.translation,
                    surahName: ayah.surahName,
                    surahNameArabic: ayah.surahNameArabic,
                    ayahNumber: ayah.ayahNumber,
                    juz: ayah.juz,
                    page: ayah.page,
                    showTranslation: _showTranslationForAyah.contains(index) ||
                        widget.showTranslation,
                    onTap: () => _toggleTranslation(index),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _goToPage(int index) {
    if (_pageController.hasClients &&
        index >= 0 &&
        index < widget.ayahs.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_currentPage < widget.ayahs.length - 1) {
      _goToPage(_currentPage + 1);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }
}
