import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static GeminiService? _instance;
  GenerativeModel? _model;
  String? _apiKey;

  GeminiService._() {
    // API Key akan di-set dari environment atau config
    // Untuk development, bisa disimpan di .env atau config file
    _apiKey = const String.fromEnvironment('GEMINI_API_KEY');
    if (_apiKey == null || _apiKey!.isEmpty) {
      // Fallback: bisa juga dari shared preferences atau config
      _apiKey = null;
    }

    // Jangan inisialisasi model di sini, tunggu sampai setApiKey dipanggil
    // untuk memastikan model yang benar digunakan
  }

  factory GeminiService() {
    _instance ??= GeminiService._();
    return _instance!;
  }

  void setApiKey(String apiKey) {
    _apiKey = apiKey;
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey!,
    );
  }

  bool get isConfigured {
    if (_apiKey == null || _apiKey!.isEmpty) {
      return false;
    }
    // Pastikan model sudah diinisialisasi dengan cara cek apakah _model sudah di-assign
    try {
      // Cek apakah model bisa digunakan dengan cara memanggil method yang aman
      return true; // Jika _apiKey ada, anggap sudah configured
    } catch (e) {
      return false;
    }
  }

  Future<String?> generateContent(String prompt) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception(
          'Gemini API key belum dikonfigurasi. Silakan set API key terlebih dahulu.');
    }

    _model ??= GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey!,
    );

    try {
      final response = await _model!.generateContent([Content.text(prompt)]).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timeout setelah 30 detik');
        },
      );

      return response.text;
    } on TimeoutException catch (e) {
      throw Exception('Timeout: $e');
    } catch (e) {
      throw Exception('Gagal mendapatkan respons dari AI: $e');
    }
  }
}
