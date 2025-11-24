class TafsirModel {
  final String ayahReference;
  final String shortTafsir;
  final String detailedTafsir;
  final List<String> keyPoints;

  TafsirModel({
    required this.ayahReference,
    required this.shortTafsir,
    required this.detailedTafsir,
    required this.keyPoints,
  });

  factory TafsirModel.fromJson(Map<String, dynamic> json) {
    return TafsirModel(
      ayahReference: json['ayah_reference'] as String,
      shortTafsir: json['short_tafsir'] as String,
      detailedTafsir: json['detailed_tafsir'] as String,
      keyPoints: (json['key_points'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ayah_reference': ayahReference,
      'short_tafsir': shortTafsir,
      'detailed_tafsir': detailedTafsir,
      'key_points': keyPoints,
    };
  }
}

