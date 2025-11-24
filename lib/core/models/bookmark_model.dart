class BookmarkModel {
  final int surahNumber;
  final int ayahNumber;
  final String surahName;
  final String surahNameArabic;
  final DateTime createdAt;
  final String? note;

  BookmarkModel({
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahName,
    required this.surahNameArabic,
    required this.createdAt,
    this.note,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      surahNumber: json['surah_number'] as int,
      ayahNumber: json['ayah_number'] as int,
      surahName: json['surah_name'] as String,
      surahNameArabic: json['surah_name_arabic'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surah_number': surahNumber,
      'ayah_number': ayahNumber,
      'surah_name': surahName,
      'surah_name_arabic': surahNameArabic,
      'created_at': createdAt.toIso8601String(),
      'note': note,
    };
  }

  String get reference => '$surahName:$ayahNumber';
  String get referenceArabic => '$surahNameArabic:$ayahNumber';
}

