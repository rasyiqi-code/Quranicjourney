import 'package:flutter/material.dart';

import 'package:quran/quran.dart' as quran;
import 'package:quran_library/quran_library.dart';
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
  final QuranLibrary _quranLibrary = QuranLibrary();

  AudioPlayerService._();

  factory AudioPlayerService() {
    _instance ??= AudioPlayerService._();
    return _instance!;
  }

  AudioPlayer get player => _audioPlayer;
  QuranLibrary get quranLibrary => _quranLibrary;

  // Convert surah and ayah to unique ayah number for quran_library
  int getUniqueAyahNumber(int surahNumber, int ayahNumber) {
    int uniqueNumber = 0;
    for (int i = 1; i < surahNumber; i++) {
      uniqueNumber += quran.getVerseCount(i);
    }
    uniqueNumber += ayahNumber;
    return uniqueNumber;
  }

  // Check if audio is downloaded for a surah
  Future<bool> isAudioDownloaded(int surahNumber) async {
    // quran_library handles this internally
    // We'll check if we can play without network
    // For now, assume it's available if downloaded previously
    return true; // quran_library will handle download/streaming automatically
  }

  // Download surah audio for offline playback
  Future<void> downloadSurah(int surahNumber) async {
    try {
      await _quranLibrary.startDownloadSurah(surahNumber: surahNumber);
    } catch (e) {
      throw Exception('Gagal mengunduh audio: $e');
    }
  }

  // Cancel ongoing download
  void cancelDownload() {
    _quranLibrary.cancelDownloadSurah();
  }

  // Initialize playlist for a surah (for backward compatibility)
  Future<void> initSurahPlaylist(int surahNumber, int totalAyahs) async {
    if (_currentSurahId == surahNumber) return;
    _currentSurahId = surahNumber;

    // With quran_library, we don't need to pre-build playlist
    // It handles the audio sources internally
    // Just mark that we're ready to play this surah
  }

  // Play entire surah from beginning
  Future<void> playSurah(int surahNumber,
      {quran.Reciter reciter = quran.Reciter.arAlafasy}) async {
    try {
      _currentSurahId = surahNumber;
      await _quranLibrary.playSurah(surahNumber: surahNumber);
    } catch (e) {
      throw Exception('Gagal memutar audio: $e');
    }
  }

  // Play specific ayah
  Future<void> playAyah(
      BuildContext context, int surahNumber, int ayahNumber) async {
    try {
      _currentSurahId = surahNumber;
      final uniqueAyahNumber = getUniqueAyahNumber(surahNumber, ayahNumber);

      // Always use playAyah as it handles seeking/playing
      await _quranLibrary.playAyah(
        context: context,
        currentAyahUniqueNumber: uniqueAyahNumber,
        playSingleAyah: false, // Continue playing subsequent ayahs
      );
    } catch (e) {
      throw Exception('Gagal memutar audio: $e');
    }
  }

  // Seek to next ayah
  Future<void> seekNextAyah(BuildContext context, int currentSurahNumber,
      int currentAyahNumber) async {
    try {
      final uniqueAyahNumber =
          getUniqueAyahNumber(currentSurahNumber, currentAyahNumber);
      await _quranLibrary.seekNextAyah(
          context: context, currentAyahUniqueNumber: uniqueAyahNumber);
    } catch (e) {
      throw Exception('Gagal melanjutkan ke ayat berikutnya: $e');
    }
  }

  // Seek to previous ayah
  Future<void> seekPreviousAyah(BuildContext context, int currentSurahNumber,
      int currentAyahNumber) async {
    try {
      final uniqueAyahNumber =
          getUniqueAyahNumber(currentSurahNumber, currentAyahNumber);
      await _quranLibrary.seekPreviousAyah(
          context: context, currentAyahUniqueNumber: uniqueAyahNumber);
    } catch (e) {
      throw Exception('Gagal kembali ke ayat sebelumnya: $e');
    }
  }

  // Play from last saved position
  Future<void> playFromLastPosition() async {
    try {
      await _quranLibrary.playLastPosition();
    } catch (e) {
      throw Exception('Gagal memutar dari posisi terakhir: $e');
    }
  }

  // Get last position as duration
  Duration get lastPosition => _quranLibrary.formatLastPositionToDuration;

  // Get last position as formatted time string
  String get lastPositionTime => _quranLibrary.formatLastPositionToTime;

  // Get current/last surah number
  int get currentSurahNumber => _quranLibrary.currentAndLastSurahNumber;

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
