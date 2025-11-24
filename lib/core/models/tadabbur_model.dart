import 'tafsir_model.dart';

enum LifeSituation {
  sedih,
  bingung,
  bersyukur,
  takut,
  marah,
  bahagia,
  khawatir,
  putusAsa,
  bangga,
  cemas,
  sakit,
  kehilanganOrang,
  stress,
  sendiri,
  sukses,
  gagal,
  iri,
  berdosa,
  tobat,
  lemah,
  kuat,
  ragu,
  yakin,
  gelisah,
  tenang,
  lelah,
  kecewa,
  rindu,
  hutang,
  difitnah,
}

class TadabburModel {
  final String ayahReference;
  final LifeSituation situation;
  final String connection;
  final String reflection;
  final TafsirModel tafsir;
  final List<String> keyPoints;

  TadabburModel({
    required this.ayahReference,
    required this.situation,
    required this.connection,
    required this.reflection,
    required this.tafsir,
    required this.keyPoints,
  });

  factory TadabburModel.fromJson(Map<String, dynamic> json) {
    return TadabburModel(
      ayahReference: json['ayah_reference'] as String,
      situation: LifeSituation.values.firstWhere(
        (e) => e.toString().split('.').last == json['situation'],
      ),
      connection: json['connection'] as String,
      reflection: json['reflection'] as String,
      tafsir: TafsirModel.fromJson(json['tafsir'] as Map<String, dynamic>),
      keyPoints: (json['key_points'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ayah_reference': ayahReference,
      'situation': situation.toString().split('.').last,
      'connection': connection,
      'reflection': reflection,
      'tafsir': tafsir.toJson(),
      'key_points': keyPoints,
    };
  }

  String situationLabel(String languageCode) {
    if (languageCode == 'en') {
      switch (situation) {
        case LifeSituation.sedih:
          return 'Sad';
        case LifeSituation.bingung:
          return 'Confused';
        case LifeSituation.bersyukur:
          return 'Grateful';
        case LifeSituation.takut:
          return 'Afraid';
        case LifeSituation.marah:
          return 'Angry';
        case LifeSituation.bahagia:
          return 'Happy';
        case LifeSituation.khawatir:
          return 'Worried';
        case LifeSituation.putusAsa:
          return 'Hopeless';
        case LifeSituation.bangga:
          return 'Proud';
        case LifeSituation.cemas:
          return 'Anxious';
        case LifeSituation.sakit:
          return 'Sick';
        case LifeSituation.kehilanganOrang:
          return 'Loss';
        case LifeSituation.stress:
          return 'Stressed';
        case LifeSituation.sendiri:
          return 'Lonely';
        case LifeSituation.sukses:
          return 'Successful';
        case LifeSituation.gagal:
          return 'Failed';
        case LifeSituation.iri:
          return 'Envious';
        case LifeSituation.berdosa:
          return 'Sinful';
        case LifeSituation.tobat:
          return 'Repentant';
        case LifeSituation.lemah:
          return 'Weak';
        case LifeSituation.kuat:
          return 'Strong';
        case LifeSituation.ragu:
          return 'Doubtful';
        case LifeSituation.yakin:
          return 'Confident';
        case LifeSituation.gelisah:
          return 'Restless';
        case LifeSituation.tenang:
          return 'Peaceful';
        case LifeSituation.lelah:
          return 'Tired';
        case LifeSituation.kecewa:
          return 'Disappointed';
        case LifeSituation.rindu:
          return 'Longing';
        case LifeSituation.hutang:
          return 'In Debt';
        case LifeSituation.difitnah:
          return 'Slandered';
      }
    }
    // Indonesian
    switch (situation) {
      case LifeSituation.sedih:
        return 'Sedih';
      case LifeSituation.bingung:
        return 'Bingung';
      case LifeSituation.bersyukur:
        return 'Bersyukur';
      case LifeSituation.takut:
        return 'Takut';
      case LifeSituation.marah:
        return 'Marah';
      case LifeSituation.bahagia:
        return 'Bahagia';
      case LifeSituation.khawatir:
        return 'Khawatir';
      case LifeSituation.putusAsa:
        return 'Putus Asa';
      case LifeSituation.bangga:
        return 'Bangga';
      case LifeSituation.cemas:
        return 'Cemas';
      case LifeSituation.sakit:
        return 'Sakit';
      case LifeSituation.kehilanganOrang:
        return 'Kehilangan Orang';
      case LifeSituation.stress:
        return 'Stress';
      case LifeSituation.sendiri:
        return 'Sendiri';
      case LifeSituation.sukses:
        return 'Sukses';
      case LifeSituation.gagal:
        return 'Gagal';
      case LifeSituation.iri:
        return 'Iri';
      case LifeSituation.berdosa:
        return 'Berdosa';
      case LifeSituation.tobat:
        return 'Tobat';
      case LifeSituation.lemah:
        return 'Lemah';
      case LifeSituation.kuat:
        return 'Kuat';
      case LifeSituation.ragu:
        return 'Ragu';
      case LifeSituation.yakin:
        return 'Yakin';
      case LifeSituation.gelisah:
        return 'Gelisah';
      case LifeSituation.tenang:
        return 'Tenang';
      case LifeSituation.lelah:
        return 'Lelah';
      case LifeSituation.kecewa:
        return 'Kecewa';
      case LifeSituation.rindu:
        return 'Rindu';
      case LifeSituation.hutang:
        return 'Terlilit Hutang';
      case LifeSituation.difitnah:
        return 'Difitnah';
    }
  }
}
