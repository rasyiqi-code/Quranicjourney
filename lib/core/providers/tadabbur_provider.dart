import 'package:flutter/foundation.dart';
import '../models/tadabbur_model.dart';
import '../models/tafsir_model.dart';

class TadabburProvider with ChangeNotifier {
  final List<TadabburModel> _tadabburList = [];
  TadabburModel? _currentTadabbur;

  List<TadabburModel> get tadabburList => _tadabburList;
  TadabburModel? get currentTadabbur => _currentTadabbur;

  void loadTadabburForSituation(LifeSituation situation) {
    _currentTadabbur = _getTadabburForSituation(situation);
    notifyListeners();
  }

  TadabburModel? _getTadabburForSituation(LifeSituation situation) {
    final tadabburMap = {
      LifeSituation.sedih: TadabburModel(
        ayahReference: '2:286',
        situation: LifeSituation.sedih,
        connection: 'connection_sedih',
        reflection: 'reflection_sedih',
        keyPoints: ['kp_sedih_1', 'kp_sedih_2', 'kp_sedih_3'],
        tafsir: TafsirModel(
          ayahReference: '2:286',
          shortTafsir: 'tafsir_sedih',
          detailedTafsir: '',
          keyPoints: ['kp_sedih_1', 'kp_sedih_2', 'kp_sedih_3'],
        ),
      ),
      LifeSituation.bingung: TadabburModel(
        ayahReference: '65:2-3',
        situation: LifeSituation.bingung,
        connection: 'connection_bingung',
        reflection: 'reflection_bingung',
        keyPoints: ['kp_bingung_1', 'kp_bingung_2', 'kp_bingung_3'],
        tafsir: TafsirModel(
          ayahReference: '65:2-3',
          shortTafsir: 'tafsir_bingung',
          detailedTafsir: '',
          keyPoints: ['kp_bingung_1', 'kp_bingung_2', 'kp_bingung_3'],
        ),
      ),
      LifeSituation.bersyukur: TadabburModel(
        ayahReference: '14:7',
        situation: LifeSituation.bersyukur,
        connection: 'connection_bersyukur',
        reflection: 'reflection_bersyukur',
        keyPoints: ['kp_bersyukur_1', 'kp_bersyukur_2', 'kp_bersyukur_3'],
        tafsir: TafsirModel(
          ayahReference: '14:7',
          shortTafsir: 'tafsir_bersyukur',
          detailedTafsir: '',
          keyPoints: ['kp_bersyukur_1', 'kp_bersyukur_2', 'kp_bersyukur_3'],
        ),
      ),
      LifeSituation.takut: TadabburModel(
        ayahReference: '3:173',
        situation: LifeSituation.takut,
        connection: 'connection_takut',
        reflection: 'reflection_takut',
        keyPoints: ['kp_takut_1', 'kp_takut_2', 'kp_takut_3'],
        tafsir: TafsirModel(
          ayahReference: '3:173',
          shortTafsir: 'tafsir_takut',
          detailedTafsir: '',
          keyPoints: ['kp_takut_1', 'kp_takut_2', 'kp_takut_3'],
        ),
      ),
      LifeSituation.marah: TadabburModel(
        ayahReference: '3:134',
        situation: LifeSituation.marah,
        connection: 'connection_marah',
        reflection: 'reflection_marah',
        keyPoints: ['kp_marah_1', 'kp_marah_2', 'kp_marah_3'],
        tafsir: TafsirModel(
          ayahReference: '3:134',
          shortTafsir: 'tafsir_marah',
          detailedTafsir: '',
          keyPoints: ['kp_marah_1', 'kp_marah_2', 'kp_marah_3'],
        ),
      ),
      LifeSituation.bahagia: TadabburModel(
        ayahReference: '10:58',
        situation: LifeSituation.bahagia,
        connection: 'connection_bahagia',
        reflection: 'reflection_bahagia',
        keyPoints: ['kp_bahagia_1', 'kp_bahagia_2', 'kp_bahagia_3'],
        tafsir: TafsirModel(
          ayahReference: '10:58',
          shortTafsir: 'tafsir_bahagia',
          detailedTafsir: '',
          keyPoints: ['kp_bahagia_1', 'kp_bahagia_2', 'kp_bahagia_3'],
        ),
      ),
      LifeSituation.khawatir: TadabburModel(
        ayahReference: '13:28',
        situation: LifeSituation.khawatir,
        connection: 'connection_khawatir',
        reflection: 'reflection_khawatir',
        keyPoints: ['kp_khawatir_1', 'kp_khawatir_2', 'kp_khawatir_3'],
        tafsir: TafsirModel(
          ayahReference: '13:28',
          shortTafsir: 'tafsir_khawatir',
          detailedTafsir: '',
          keyPoints: ['kp_khawatir_1', 'kp_khawatir_2', 'kp_khawatir_3'],
        ),
      ),
      LifeSituation.putusAsa: TadabburModel(
        ayahReference: '12:87',
        situation: LifeSituation.putusAsa,
        connection: 'connection_putusAsa',
        reflection: 'reflection_putusAsa',
        keyPoints: ['kp_putusAsa_1', 'kp_putusAsa_2', 'kp_putusAsa_3'],
        tafsir: TafsirModel(
          ayahReference: '12:87',
          shortTafsir: 'tafsir_putusAsa',
          detailedTafsir: '',
          keyPoints: ['kp_putusAsa_1', 'kp_putusAsa_2', 'kp_putusAsa_3'],
        ),
      ),
      LifeSituation.bangga: TadabburModel(
        ayahReference: '31:18',
        situation: LifeSituation.bangga,
        connection: 'connection_bangga',
        reflection: 'reflection_bangga',
        keyPoints: ['kp_bangga_1', 'kp_bangga_2', 'kp_bangga_3'],
        tafsir: TafsirModel(
          ayahReference: '31:18',
          shortTafsir: 'tafsir_bangga',
          detailedTafsir: '',
          keyPoints: ['kp_bangga_1', 'kp_bangga_2', 'kp_bangga_3'],
        ),
      ),
      LifeSituation.cemas: TadabburModel(
        ayahReference: '2:152',
        situation: LifeSituation.cemas,
        connection: 'connection_cemas',
        reflection: 'reflection_cemas',
        keyPoints: ['kp_cemas_1', 'kp_cemas_2', 'kp_cemas_3'],
        tafsir: TafsirModel(
          ayahReference: '2:152',
          shortTafsir: 'tafsir_cemas',
          detailedTafsir: '',
          keyPoints: ['kp_cemas_1', 'kp_cemas_2', 'kp_cemas_3'],
        ),
      ),
      LifeSituation.sakit: TadabburModel(
        ayahReference: '26:80',
        situation: LifeSituation.sakit,
        connection: 'connection_sakit',
        reflection: 'reflection_sakit',
        keyPoints: ['kp_sakit_1', 'kp_sakit_2', 'kp_sakit_3'],
        tafsir: TafsirModel(
          ayahReference: '26:80',
          shortTafsir: 'tafsir_sakit',
          detailedTafsir: '',
          keyPoints: ['kp_sakit_1', 'kp_sakit_2', 'kp_sakit_3'],
        ),
      ),
      LifeSituation.kehilanganOrang: TadabburModel(
        ayahReference: '2:156',
        situation: LifeSituation.kehilanganOrang,
        connection: 'connection_kehilanganOrang',
        reflection: 'reflection_kehilanganOrang',
        keyPoints: [
          'kp_kehilanganOrang_1',
          'kp_kehilanganOrang_2',
          'kp_kehilanganOrang_3'
        ],
        tafsir: TafsirModel(
          ayahReference: '2:156',
          shortTafsir: 'tafsir_kehilanganOrang',
          detailedTafsir: '',
          keyPoints: [
            'kp_kehilanganOrang_1',
            'kp_kehilanganOrang_2',
            'kp_kehilanganOrang_3'
          ],
        ),
      ),
      LifeSituation.stress: TadabburModel(
        ayahReference: '94:5-6',
        situation: LifeSituation.stress,
        connection: 'connection_stress',
        reflection: 'reflection_stress',
        keyPoints: ['kp_stress_1', 'kp_stress_2', 'kp_stress_3'],
        tafsir: TafsirModel(
          ayahReference: '94:5-6',
          shortTafsir: 'tafsir_stress',
          detailedTafsir: '',
          keyPoints: ['kp_stress_1', 'kp_stress_2', 'kp_stress_3'],
        ),
      ),
      LifeSituation.sendiri: TadabburModel(
        ayahReference: '50:16',
        situation: LifeSituation.sendiri,
        connection: 'connection_sendiri',
        reflection: 'reflection_sendiri',
        keyPoints: ['kp_sendiri_1', 'kp_sendiri_2', 'kp_sendiri_3'],
        tafsir: TafsirModel(
          ayahReference: '50:16',
          shortTafsir: 'tafsir_sendiri',
          detailedTafsir: '',
          keyPoints: ['kp_sendiri_1', 'kp_sendiri_2', 'kp_sendiri_3'],
        ),
      ),
      LifeSituation.sukses: TadabburModel(
        ayahReference: '27:40',
        situation: LifeSituation.sukses,
        connection: 'connection_sukses',
        reflection: 'reflection_sukses',
        keyPoints: ['kp_sukses_1', 'kp_sukses_2', 'kp_sukses_3'],
        tafsir: TafsirModel(
          ayahReference: '27:40',
          shortTafsir: 'tafsir_sukses',
          detailedTafsir: '',
          keyPoints: ['kp_sukses_1', 'kp_sukses_2', 'kp_sukses_3'],
        ),
      ),
      LifeSituation.gagal: TadabburModel(
        ayahReference: '3:139',
        situation: LifeSituation.gagal,
        connection: 'connection_gagal',
        reflection: 'reflection_gagal',
        keyPoints: ['kp_gagal_1', 'kp_gagal_2', 'kp_gagal_3'],
        tafsir: TafsirModel(
          ayahReference: '3:139',
          shortTafsir: 'tafsir_gagal',
          detailedTafsir: '',
          keyPoints: ['kp_gagal_1', 'kp_gagal_2', 'kp_gagal_3'],
        ),
      ),
      LifeSituation.iri: TadabburModel(
        ayahReference: '4:32',
        situation: LifeSituation.iri,
        connection: 'connection_iri',
        reflection: 'reflection_iri',
        keyPoints: ['kp_iri_1', 'kp_iri_2', 'kp_iri_3'],
        tafsir: TafsirModel(
          ayahReference: '4:32',
          shortTafsir: 'tafsir_iri',
          detailedTafsir: '',
          keyPoints: ['kp_iri_1', 'kp_iri_2', 'kp_iri_3'],
        ),
      ),
      LifeSituation.berdosa: TadabburModel(
        ayahReference: '39:53',
        situation: LifeSituation.berdosa,
        connection: 'connection_berdosa',
        reflection: 'reflection_berdosa',
        keyPoints: ['kp_berdosa_1', 'kp_berdosa_2', 'kp_berdosa_3'],
        tafsir: TafsirModel(
          ayahReference: '39:53',
          shortTafsir: 'tafsir_berdosa',
          detailedTafsir: '',
          keyPoints: ['kp_berdosa_1', 'kp_berdosa_2', 'kp_berdosa_3'],
        ),
      ),
      LifeSituation.tobat: TadabburModel(
        ayahReference: '66:8',
        situation: LifeSituation.tobat,
        connection: 'connection_tobat',
        reflection: 'reflection_tobat',
        keyPoints: ['kp_tobat_1', 'kp_tobat_2', 'kp_tobat_3'],
        tafsir: TafsirModel(
          ayahReference: '66:8',
          shortTafsir: 'tafsir_tobat',
          detailedTafsir: '',
          keyPoints: ['kp_tobat_1', 'kp_tobat_2', 'kp_tobat_3'],
        ),
      ),
      LifeSituation.lemah: TadabburModel(
        ayahReference: '4:28',
        situation: LifeSituation.lemah,
        connection: 'connection_lemah',
        reflection: 'reflection_lemah',
        keyPoints: ['kp_lemah_1', 'kp_lemah_2', 'kp_lemah_3'],
        tafsir: TafsirModel(
          ayahReference: '4:28',
          shortTafsir: 'tafsir_lemah',
          detailedTafsir: '',
          keyPoints: ['kp_lemah_1', 'kp_lemah_2', 'kp_lemah_3'],
        ),
      ),
      LifeSituation.kuat: TadabburModel(
        ayahReference: '8:65',
        situation: LifeSituation.kuat,
        connection: 'connection_kuat',
        reflection: 'reflection_kuat',
        keyPoints: ['kp_kuat_1', 'kp_kuat_2', 'kp_kuat_3'],
        tafsir: TafsirModel(
          ayahReference: '8:65',
          shortTafsir: 'tafsir_kuat',
          detailedTafsir: '',
          keyPoints: ['kp_kuat_1', 'kp_kuat_2', 'kp_kuat_3'],
        ),
      ),
      LifeSituation.ragu: TadabburModel(
        ayahReference: '2:147',
        situation: LifeSituation.ragu,
        connection: 'connection_ragu',
        reflection: 'reflection_ragu',
        keyPoints: ['kp_ragu_1', 'kp_ragu_2', 'kp_ragu_3'],
        tafsir: TafsirModel(
          ayahReference: '2:147',
          shortTafsir: 'tafsir_ragu',
          detailedTafsir: '',
          keyPoints: ['kp_ragu_1', 'kp_ragu_2', 'kp_ragu_3'],
        ),
      ),
      LifeSituation.yakin: TadabburModel(
        ayahReference: '41:30',
        situation: LifeSituation.yakin,
        connection: 'connection_yakin',
        reflection: 'reflection_yakin',
        keyPoints: ['kp_yakin_1', 'kp_yakin_2', 'kp_yakin_3'],
        tafsir: TafsirModel(
          ayahReference: '41:30',
          shortTafsir: 'tafsir_yakin',
          detailedTafsir: '',
          keyPoints: ['kp_yakin_1', 'kp_yakin_2', 'kp_yakin_3'],
        ),
      ),
      LifeSituation.gelisah: TadabburModel(
        ayahReference: '20:2',
        situation: LifeSituation.gelisah,
        connection: 'connection_gelisah',
        reflection: 'reflection_gelisah',
        keyPoints: ['kp_gelisah_1', 'kp_gelisah_2', 'kp_gelisah_3'],
        tafsir: TafsirModel(
          ayahReference: '20:2',
          shortTafsir: 'tafsir_gelisah',
          detailedTafsir: '',
          keyPoints: ['kp_gelisah_1', 'kp_gelisah_2', 'kp_gelisah_3'],
        ),
      ),
      LifeSituation.tenang: TadabburModel(
        ayahReference: '89:27-30',
        situation: LifeSituation.tenang,
        connection: 'connection_tenang',
        reflection: 'reflection_tenang',
        keyPoints: ['kp_tenang_1', 'kp_tenang_2', 'kp_tenang_3'],
        tafsir: TafsirModel(
          ayahReference: '89:27-30',
          shortTafsir: 'tafsir_tenang',
          detailedTafsir: '',
          keyPoints: ['kp_tenang_1', 'kp_tenang_2', 'kp_tenang_3'],
        ),
      ),
      LifeSituation.lelah: TadabburModel(
        ayahReference: '2:153',
        situation: LifeSituation.lelah,
        connection: 'connection_lelah',
        reflection: 'reflection_lelah',
        keyPoints: ['kp_lelah_1', 'kp_lelah_2', 'kp_lelah_3'],
        tafsir: TafsirModel(
          ayahReference: '2:153',
          shortTafsir: 'tafsir_lelah',
          detailedTafsir: '',
          keyPoints: ['kp_lelah_1', 'kp_lelah_2', 'kp_lelah_3'],
        ),
      ),
      LifeSituation.kecewa: TadabburModel(
        ayahReference: '2:216',
        situation: LifeSituation.kecewa,
        connection: 'connection_kecewa',
        reflection: 'reflection_kecewa',
        keyPoints: ['kp_kecewa_1', 'kp_kecewa_2', 'kp_kecewa_3'],
        tafsir: TafsirModel(
          ayahReference: '2:216',
          shortTafsir: 'tafsir_kecewa',
          detailedTafsir: '',
          keyPoints: ['kp_kecewa_1', 'kp_kecewa_2', 'kp_kecewa_3'],
        ),
      ),
      LifeSituation.rindu: TadabburModel(
        ayahReference: '12:86',
        situation: LifeSituation.rindu,
        connection: 'connection_rindu',
        reflection: 'reflection_rindu',
        keyPoints: ['kp_rindu_1', 'kp_rindu_2', 'kp_rindu_3'],
        tafsir: TafsirModel(
          ayahReference: '12:86',
          shortTafsir: 'tafsir_rindu',
          detailedTafsir: '',
          keyPoints: ['kp_rindu_1', 'kp_rindu_2', 'kp_rindu_3'],
        ),
      ),
      LifeSituation.hutang: TadabburModel(
        ayahReference: '2:280',
        situation: LifeSituation.hutang,
        connection: 'connection_hutang',
        reflection: 'reflection_hutang',
        keyPoints: ['kp_hutang_1', 'kp_hutang_2', 'kp_hutang_3'],
        tafsir: TafsirModel(
          ayahReference: '2:280',
          shortTafsir: 'tafsir_hutang',
          detailedTafsir: '',
          keyPoints: ['kp_hutang_1', 'kp_hutang_2', 'kp_hutang_3'],
        ),
      ),
      LifeSituation.difitnah: TadabburModel(
        ayahReference: '24:11',
        situation: LifeSituation.difitnah,
        connection: 'connection_difitnah',
        reflection: 'reflection_difitnah',
        keyPoints: ['kp_difitnah_1', 'kp_difitnah_2', 'kp_difitnah_3'],
        tafsir: TafsirModel(
          ayahReference: '24:11',
          shortTafsir: 'tafsir_difitnah',
          detailedTafsir: '',
          keyPoints: ['kp_difitnah_1', 'kp_difitnah_2', 'kp_difitnah_3'],
        ),
      ),
    };

    return tadabburMap[situation];
  }

  List<TadabburModel> getTadabburBySituation(LifeSituation situation) {
    return _tadabburList.where((t) => t.situation == situation).toList();
  }
}
