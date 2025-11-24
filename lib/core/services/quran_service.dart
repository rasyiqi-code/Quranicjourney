import 'package:quran/quran.dart' as quran;
import '../models/ayah_model.dart';

class QuranService {
  static QuranService? _instance;

  QuranService._();

  factory QuranService() {
    _instance ??= QuranService._();
    return _instance!;
  }

  // Get single ayah
  AyahModel getAyah(int surahNumber, int ayahNumber,
      {String translationCode = 'id'}) {
    quran.Translation translation;
    switch (translationCode) {
      case 'en':
        translation = quran.Translation.enSaheeh;
        break;
      case 'id':
      default:
        translation = quran.Translation.indonesian;
        break;
    }

    return AyahModel(
      surahNumber: surahNumber,
      surahName: quran.getSurahName(surahNumber),
      surahNameArabic: quran.getSurahNameArabic(surahNumber),
      ayahNumber: ayahNumber,
      arabicText: quran.getVerse(surahNumber, ayahNumber),
      translation: quran.getVerseTranslation(
        surahNumber,
        ayahNumber,
        translation: translation,
      ),
      transliteration: quran.getVerseTranslation(
        surahNumber,
        ayahNumber,
        translation: quran.Translation.enSaheeh,
      ),
      juz: quran.getJuzNumber(surahNumber, ayahNumber),
      page: quran.getPageNumber(surahNumber, ayahNumber),
    );
  }

  // Get all ayahs in a surah
  List<AyahModel> getSurah(int surahNumber, {String translationCode = 'id'}) {
    final verseCount = quran.getVerseCount(surahNumber);
    final ayahs = <AyahModel>[];

    for (int i = 1; i <= verseCount; i++) {
      ayahs.add(getAyah(surahNumber, i, translationCode: translationCode));
    }

    return ayahs;
  }

  // Get ayahs by page
  List<AyahModel> getAyahsByPage(int pageNumber) {
    final pageData = quran.getPageData(pageNumber);
    final ayahs = <AyahModel>[];

    for (var surahData in pageData) {
      final surahNumber = surahData['surah'] as int;
      final startVerse = surahData['startVerse'] as int;
      final endVerse = surahData['endVerse'] as int;

      for (int verse = startVerse; verse <= endVerse; verse++) {
        ayahs.add(getAyah(surahNumber, verse));
      }
    }

    return ayahs;
  }

  // Get ayahs by juz
  List<AyahModel> getAyahsByJuz(int juzNumber) {
    final juzData = quran.getSurahAndVersesFromJuz(juzNumber);
    final ayahs = <AyahModel>[];

    for (var entry in juzData.entries) {
      final surahNumber = entry.key;
      final verses = entry.value;

      for (var verseNumber in verses) {
        ayahs.add(getAyah(surahNumber, verseNumber));
      }
    }

    return ayahs;
  }

  // Get surah info
  Map<String, dynamic> getSurahInfo(int surahNumber) {
    return {
      'name': quran.getSurahName(surahNumber),
      'nameArabic': quran.getSurahNameArabic(surahNumber),
      'nameEnglish': quran.getSurahNameEnglish(surahNumber),
      'verseCount': quran.getVerseCount(surahNumber),
      'placeOfRevelation': quran.getPlaceOfRevelation(surahNumber),
      'pages': quran.getSurahPages(surahNumber),
    };
  }

  // Get audio URL
  String getAudioURL(int surahNumber, {int? ayahNumber}) {
    if (ayahNumber != null) {
      return quran.getAudioURLByVerse(
        surahNumber,
        ayahNumber,
        reciter: quran.Reciter.arAlafasy,
      );
    }
    return quran.getAudioURLBySurah(
      surahNumber,
      reciter: quran.Reciter.arAlafasy,
    );
  }

  // Get all surahs list
  List<Map<String, dynamic>> getAllSurahs() {
    final surahs = <Map<String, dynamic>>[];

    for (int i = 1; i <= quran.totalSurahCount; i++) {
      surahs.add({
        'number': i,
        'name': quran.getSurahName(i),
        'nameArabic': quran.getSurahNameArabic(i),
        'verseCount': quran.getVerseCount(i),
        'placeOfRevelation': quran.getPlaceOfRevelation(i),
      });
    }

    return surahs;
  }

  // Search in Quran
  Map<String, dynamic> searchInQuran(List<String> words) {
    return Map<String, dynamic>.from(quran.searchWords(words));
  }

  // Search in translation
  Map<String, dynamic> searchInTranslation(
    List<String> words, {
    quran.Translation translation = quran.Translation.indonesian,
  }) {
    return Map<String, dynamic>.from(
        quran.searchWordsInTranslation(words, translation: translation));
  }

  // Count Hijaiyah letters
  int countHijaiyahLetters(String text) {
    // Remove non-Arabic characters and diacritics (tashkeel)
    // This is a simplified approach. For more accuracy, we might need a more complex regex
    // or a dedicated library.
    // The range \u0600-\u06FF includes Arabic characters.
    // We want to count letters, not diacritics.

    // Common Arabic letters
    final RegExp arabicLetters = RegExp(r'[\u0621-\u064A]');

    int count = 0;
    for (int i = 0; i < text.length; i++) {
      if (arabicLetters.hasMatch(text[i])) {
        count++;
      }
    }
    return count;
  }

  // Get random verse
  AyahModel getRandomAyah() {
    final randomVerse = quran.RandomVerse();
    return getAyah(randomVerse.surahNumber, randomVerse.verseNumber);
  }

  // Constants
  String get basmala => quran.basmala;
  int get totalSurahCount => quran.totalSurahCount;
  int get totalVerseCount => quran.totalVerseCount;
  int get totalJuzCount => quran.totalJuzCount;
  int get totalPagesCount => quran.totalPagesCount;
}
