import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/funfact_model.dart';
import '../database/funfact_database.dart';
import 'gemini_service.dart';

class FunfactService {
  static FunfactService? _instance;
  final GeminiService _geminiService = GeminiService();

  FunfactService._();

  factory FunfactService() {
    _instance ??= FunfactService._();
    return _instance!;
  }

  void setGeminiApiKey(String apiKey) {
    _geminiService.setApiKey(apiKey);
  }

  // Get daily funfact - generate jika belum ada untuk hari ini
  Future<FunfactModel?> getDailyFunfact({String languageCode = 'id'}) async {
    try {
      final today = DateTime.now();
      final dateStr = _formatDate(today, languageCode);

      // Cek apakah sudah ada untuk hari ini
      final db = FunfactDatabase();
      final existing = await db.getFunfactByDate(dateStr);

      if (existing != null) {
        debugPrint(
            'Funfact untuk hari ini ($languageCode) sudah ada, menggunakan yang tersimpan');
        return FunfactModel.fromJson(existing);
      }

      // Generate baru dengan AI
      debugPrint(
          'Belum ada funfact untuk hari ini ($languageCode), generating...');

      // Rotasi kategori setiap hari (4 kategori, rotasi berdasarkan hari)
      final categories = ['funfact', 'quran_fact', 'hadith', 'islam_fact'];
      final categoryIndex = today.day % categories.length;
      final category = categories[categoryIndex];

      try {
        final funfact = await _generateFunfactFromAI(
          category: category,
          languageCode: languageCode,
        );

        if (funfact != null) {
          // Simpan ke database
          await db.insertFunfact(
            date: dateStr,
            category: funfact.category,
            title: funfact.title,
            content: funfact.content,
            source: funfact.source,
            reference: funfact.reference,
          );

          // Maintain max 30 funfacts
          await db.maintainMax30Funfacts();

          // Update funfact dengan date
          return FunfactModel(
            id: funfact.id,
            title: funfact.title,
            category: funfact.category,
            content: funfact.content,
            source: funfact.source,
            reference: funfact.reference,
            imageUrl: funfact.imageUrl,
            date: dateStr,
          );
        }
      } catch (e) {
        debugPrint('Error generating funfact dengan AI: $e');
        debugPrint('Mencoba fallback ke random funfact dari database...');

        // Fallback: ambil random dari database
        final random = await db.getRandomFunfact();
        if (random != null) {
          debugPrint(
              'Menggunakan funfact random dari database sebagai fallback');
          return FunfactModel.fromJson(random);
        }

        // Jika tidak ada di database juga, throw error
        throw Exception(
            'Tidak ada funfact yang tersedia. Pastikan koneksi internet aktif untuk generate funfact pertama.');
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('Error in getDailyFunfact: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Generate funfact manual (untuk user request)
  Future<FunfactModel?> generateFunfact({
    String category = 'funfact',
    String languageCode = 'id',
  }) async {
    try {
      // Generate funfact menggunakan AI
      final funfact = await _generateFunfactFromAI(
        category: category,
        languageCode: languageCode,
      );
      return funfact;
    } catch (e, stackTrace) {
      debugPrint('Error in generateFunfact: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  String _formatDate(DateTime date, String languageCode) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}_$languageCode';
  }

  // Get all funfacts from database
  Future<List<FunfactModel>> getAllFunfacts({String? category}) async {
    try {
      final db = FunfactDatabase();
      final allFunfacts = await db.getAllFunfacts();

      final funfacts = allFunfacts
          .map((json) => FunfactModel.fromJson(json))
          .where((funfact) => category == null || funfact.category == category)
          .toList();

      return funfacts;
    } catch (e) {
      debugPrint('Error getting all funfacts: $e');
      return [];
    }
  }

  // Get random funfact from database (for fallback)
  Future<FunfactModel?> getRandomFunfact() async {
    try {
      final db = FunfactDatabase();
      final random = await db.getRandomFunfact();
      return random != null ? FunfactModel.fromJson(random) : null;
    } catch (e) {
      debugPrint('Error getting random funfact: $e');
      return null;
    }
  }

  Future<void> clearAllFunfacts() async {
    // Note: Clear database if needed
    // For now, we keep the database for persistence
    debugPrint('Funfacts are stored in database and will persist');
  }

  Future<FunfactModel?> _generateFunfactFromAI({
    required String category,
    required String languageCode,
  }) async {
    String prompt = '';
    final isEn = languageCode == 'en';

    switch (category) {
      case 'funfact':
        prompt = isEn
            ? '''
Create one interesting fun fact about Islam, Quran, or general Islamic knowledge.
Requirements:
- Interesting and informative
- Based on accurate facts
- Length 100-150 words
- Written in easy-to-understand English
- Can be about Islamic history, figures, or general knowledge

Response format: JSON with structure:
{
  "title": "Funfact Title",
  "content": "Interesting funfact content",
  "source": "Source (optional)"
}
'''
            : '''
Buatkan satu funfact menarik tentang Islam, Al-Quran, atau agama Islam secara umum. 
Funfact harus:
- Menarik dan informatif
- Berdasarkan fakta yang akurat
- Panjang 100-150 kata
- Ditulis dalam bahasa Indonesia yang mudah dipahami
- Bisa tentang sejarah Islam, tokoh Islam, atau pengetahuan umum tentang Islam

Format respons: JSON dengan struktur:
{
  "title": "Judul funfact",
  "content": "Isi funfact yang menarik",
  "source": "Sumber (opsional)"
}
''';
        break;
      case 'quran_fact':
        prompt = isEn
            ? '''
Create one unique fact about the Quran.
Requirements:
- Unique and interesting
- Based on accurate facts about the Quran
- Length 100-150 words
- Written in easy-to-understand English
- Can be about Quran structure, history, unique verses, etc.

Response format: JSON with structure:
{
  "title": "Fact Title",
  "content": "Unique Quran fact content",
  "reference": "Verse or Surah reference (if any)"
}
'''
            : '''
Buatkan satu fakta unik tentang Al-Quran. 
Fakta harus:
- Unik dan menarik
- Berdasarkan fakta yang akurat tentang Al-Quran
- Panjang 100-150 kata
- Ditulis dalam bahasa Indonesia yang mudah dipahami
- Bisa tentang struktur Al-Quran, sejarah penulisan, keunikan ayat, dll

Format respons: JSON dengan struktur:
{
  "title": "Judul fakta",
  "content": "Isi fakta unik tentang Al-Quran",
  "reference": "Referensi ayat atau surah (jika ada)"
}
''';
        break;
      case 'hadith':
        prompt = isEn
            ? '''
Create one authentic Hadith with explanation.
Requirements:
- Authentic (Shahih) and trusted
- Include explanation of meaning and wisdom
- Length 150-200 words
- Written in easy-to-understand English
- Include Hadith source (Bukhari, Muslim, etc.)

Response format: JSON with structure:
{
  "title": "Hadith Title",
  "content": "Hadith text and explanation",
  "source": "Hadith Source (Bukhari/Muslim/etc)",
  "reference": "Hadith Reference"
}
'''
            : '''
Buatkan satu hadits shahih yang menarik beserta penjelasannya. 
Hadits harus:
- Shahih dan terpercaya
- Disertai penjelasan makna dan hikmah
- Panjang 150-200 kata
- Ditulis dalam bahasa Indonesia yang mudah dipahami
- Sertakan sumber hadits (Shahih Bukhari, Muslim, dll)

Format respons: JSON dengan struktur:
{
  "title": "Judul hadits",
  "content": "Teks hadits dan penjelasannya",
  "source": "Sumber hadits (Shahih Bukhari/Muslim/dll)",
  "reference": "Referensi hadits"
}
''';
        break;
      case 'islam_fact':
        prompt = isEn
            ? '''
Create one interesting fact about Islam in general.
Requirements:
- Interesting and informative
- Based on accurate facts
- Length 100-150 words
- Written in easy-to-understand English
- Can be about Islamic history, teachings, or general knowledge

Response format: JSON with structure:
{
  "title": "Fact Title",
  "content": "Interesting Islamic fact content",
  "source": "Source (optional)"
}
'''
            : '''
Buatkan satu fakta menarik tentang agama Islam secara umum. 
Fakta harus:
- Menarik dan informatif
- Berdasarkan fakta yang akurat
- Panjang 100-150 kata
- Ditulis dalam bahasa Indonesia yang mudah dipahami
- Bisa tentang sejarah Islam, ajaran Islam, atau pengetahuan umum tentang Islam

Format respons: JSON dengan struktur:
{
  "title": "Judul fakta",
  "content": "Isi fakta menarik tentang Islam",
  "source": "Sumber (opsional)"
}
''';
        break;
    }

    try {
      debugPrint(
          'Generating funfact for category: $category ($languageCode)...');

      if (!_geminiService.isConfigured) {
        throw Exception('Gemini API key belum dikonfigurasi');
      }

      final responseText = await _geminiService.generateContent(prompt);
      if (responseText == null || responseText.isEmpty) {
        throw Exception('AI tidak mengembalikan respons');
      }
      final response = responseText;

      // Parse JSON response
      String cleanJson = response.trim();
      if (cleanJson.startsWith('```json')) {
        cleanJson = cleanJson.substring(7);
      }
      if (cleanJson.startsWith('```')) {
        cleanJson = cleanJson.substring(3);
      }
      if (cleanJson.endsWith('```')) {
        cleanJson = cleanJson.substring(0, cleanJson.length - 3);
      }
      cleanJson = cleanJson.trim();

      final json = jsonDecode(cleanJson) as Map<String, dynamic>;

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final dateStr = _formatDate(DateTime.now(), languageCode);
      return FunfactModel(
        id: 'funfact_${category}_${languageCode}_$timestamp',
        title: json['title']?.toString() ?? 'Fakta Menarik',
        category: category,
        content: json['content']?.toString() ?? '',
        source: json['source']?.toString(),
        reference: json['reference']?.toString(),
        date: dateStr,
      );
    } catch (e, stackTrace) {
      debugPrint('Error generating funfact: $e');
      debugPrint('Stack trace: $stackTrace');

      String errorMessage = 'Gagal mendapatkan funfact';
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Failed host lookup')) {
        errorMessage =
            'Tidak ada koneksi internet. Pastikan perangkat terhubung ke internet.';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timeout. Silakan coba lagi.';
      } else if (e.toString().contains('API key')) {
        errorMessage = 'API key Gemini belum dikonfigurasi.';
      }

      throw Exception(errorMessage);
    }
  }
}
