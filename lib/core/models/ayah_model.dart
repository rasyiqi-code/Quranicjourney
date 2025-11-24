class AyahModel {
  final int surahNumber;
  final String surahName;
  final String surahNameArabic;
  final int ayahNumber;
  final String arabicText;
  final String translation;
  final String transliteration;
  final int juz;
  final int page;

  AyahModel({
    required this.surahNumber,
    required this.surahName,
    required this.surahNameArabic,
    required this.ayahNumber,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
    required this.juz,
    required this.page,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      surahNumber: json['surah_number'] as int,
      surahName: json['surah_name'] as String,
      surahNameArabic: json['surah_name_arabic'] as String,
      ayahNumber: json['ayah_number'] as int,
      arabicText: json['arabic_text'] as String,
      translation: json['translation'] as String,
      transliteration: json['transliteration'] as String,
      juz: json['juz'] as int,
      page: json['page'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surah_number': surahNumber,
      'surah_name': surahName,
      'surah_name_arabic': surahNameArabic,
      'ayah_number': ayahNumber,
      'arabic_text': arabicText,
      'translation': translation,
      'transliteration': transliteration,
      'juz': juz,
      'page': page,
    };
  }

  String get fullReference => '$surahName:$ayahNumber';
}

