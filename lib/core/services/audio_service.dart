import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;
import 'dart:async';

class AudioPlayerService {
  static AudioPlayerService? _instance;
  final AudioPlayer _audioPlayer = AudioPlayer(
    audioLoadConfiguration: const AudioLoadConfiguration(
      androidLoadControl: AndroidLoadControl(
        minBufferDuration: Duration(seconds: 15),
        maxBufferDuration: Duration(seconds: 50),
        bufferForPlaybackDuration: Duration(seconds: 2),
        bufferForPlaybackAfterRebufferDuration: Duration(seconds: 5),
      ),
      darwinLoadControl: DarwinLoadControl(
        automaticallyWaitsToMinimizeStalling: true,
      ),
    ),
  );

  int? _currentSurahId;

  AudioPlayerService._();

  factory AudioPlayerService() {
    _instance ??= AudioPlayerService._();
    return _instance!;
  }

  AudioPlayer get player => _audioPlayer;

  Future<void> initSurahPlaylist(int surahNumber, int totalAyahs) async {
    if (_currentSurahId == surahNumber) return;

    _currentSurahId = surahNumber;
    final children = List<AudioSource>.generate(totalAyahs, (index) {
      final surah = surahNumber.toString().padLeft(3, '0');
      final ayah = (index + 1).toString().padLeft(3, '0');
      final url = 'https://everyayah.com/data/Alafasy_128kbps/$surah$ayah.mp3';
      return AudioSource.uri(Uri.parse(url));
    });

    try {
      await _audioPlayer.setAudioSources(children);
    } catch (e) {
      throw Exception('Gagal memuat playlist: $e');
    }
  }

  Future<void> playSurah(int surahNumber,
      {quran.Reciter reciter = quran.Reciter.arAlafasy}) async {
    try {
      final url = quran.getAudioURLBySurah(surahNumber, reciter: reciter);
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      throw Exception('Gagal memutar audio: $e');
    }
  }

  Future<void> playAyah(int surahNumber, int ayahNumber) async {
    try {
      if (_currentSurahId == surahNumber) {
        await _audioPlayer.seek(Duration.zero, index: ayahNumber - 1);
        await _audioPlayer.play();
      } else {
        final surah = surahNumber.toString().padLeft(3, '0');
        final ayah = ayahNumber.toString().padLeft(3, '0');
        final url =
            'https://everyayah.com/data/Alafasy_128kbps/$surah$ayah.mp3';

        await _audioPlayer.setUrl(url);
        await _audioPlayer.play();
      }
    } catch (e) {
      throw Exception('Gagal memutar audio: $e');
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  Duration? get duration => _audioPlayer.duration;
  Duration get position => _audioPlayer.position;
  bool get playing => _audioPlayer.playing;
  bool get paused => !_audioPlayer.playing;

  void dispose() {
    _audioPlayer.dispose();
  }
}
