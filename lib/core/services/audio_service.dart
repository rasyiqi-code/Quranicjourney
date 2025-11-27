import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  int? _currentSurah;
  int? _currentAyah;

  bool get isPlaying => _isPlaying;
  int? get currentSurah => _currentSurah;
  int? get currentAyah => _currentAyah;

  // Stream for player state changes
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  // Get audio URL for specific ayah
  String _getAudioUrl(int surah, int ayah) {
    String surahStr = surah.toString().padLeft(3, '0');
    String ayahStr = ayah.toString().padLeft(3, '0');
    // Using Alafasy recitation as default
    return 'https://everyayah.com/data/Alafasy_128kbps/$surahStr$ayahStr.mp3';
  }

  // Get local file path for specific ayah
  Future<String> _getLocalFilePath(int surah, int ayah) async {
    final directory = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${directory.path}/audio_cache');
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }
    return '${audioDir.path}/${surah}_$ayah.mp3';
  }

  // Check if audio file exists locally
  Future<bool> _isAudioCached(int surah, int ayah) async {
    final path = await _getLocalFilePath(surah, ayah);
    return File(path).exists();
  }

  // Download audio file
  Future<String> _downloadAudio(int surah, int ayah) async {
    final url = _getAudioUrl(surah, ayah);
    final path = await _getLocalFilePath(surah, ayah);
    final file = File(path);

    if (await file.exists()) {
      return path;
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        return path;
      } else {
        throw Exception('Failed to download audio: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading audio: $e');
    }
  }

  // Play ayah audio
  Future<void> playAyah(int surah, int ayah) async {
    try {
      _currentSurah = surah;
      _currentAyah = ayah;
      _isPlaying = true;

      // Check if cached
      final isCached = await _isAudioCached(surah, ayah);

      if (isCached) {
        final path = await _getLocalFilePath(surah, ayah);
        await _player.setFilePath(path);
      } else {
        // If not cached, play from URL and download in background
        // OR download first then play (as requested "download to local storage")
        // To ensure smooth UX, we'll try to download first, but if it takes too long
        // we might want to stream.
        // For now, let's follow the request: download then play.

        // However, downloading might block UI if awaited.
        // Let's download and await, showing loading state in UI is handled by FutureBuilder or async state.
        final path = await _downloadAudio(surah, ayah);
        await _player.setFilePath(path);
      }

      await _player.play();

      // Reset state when finished
      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _isPlaying = false;
          _currentSurah = null;
          _currentAyah = null;
        }
      });
    } catch (e) {
      _isPlaying = false;
      _currentSurah = null;
      _currentAyah = null;
      rethrow;
    }
  }

  Future<void> pause() async {
    await _player.pause();
    _isPlaying = false;
  }

  Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
    _currentSurah = null;
    _currentAyah = null;
  }

  Future<void> resume() async {
    await _player.play();
    _isPlaying = true;
  }

  void dispose() {
    _player.dispose();
  }
}
