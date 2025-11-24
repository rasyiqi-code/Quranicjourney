import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_progress_model.dart';

class UserProgressProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  UserProgressModel _progress;

  UserProgressProvider(this._prefs) : _progress = UserProgressModel.initial() {
    _loadProgress();
  }

  UserProgressModel get progress => _progress;

  void _loadProgress() {
    final progressJson = _prefs.getString('user_progress');
    if (progressJson != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(progressJson);
        _progress = UserProgressModel.fromJson(json);
      } catch (e) {
        _progress = UserProgressModel.initial();
      }
    }
    _updateStreak();
  }

  void _saveProgress() {
    final json = _progress.toJson();
    final jsonString = jsonEncode(json);
    _prefs.setString('user_progress', jsonString);
  }

  void _updateStreak() {
    final now = DateTime.now();
    final lastRead = _progress.lastReadDate;
    final difference = now.difference(lastRead).inDays;

    if (difference == 0) {
      return;
    } else if (difference == 1) {
      _progress = UserProgressModel(
        totalAyahRead: _progress.totalAyahRead,
        totalDaysStreak: _progress.totalDaysStreak + 1,
        currentStreak: _progress.currentStreak + 1,
        lastReadDate: now,
        totalPoints: _progress.totalPoints,
        level: _progress.level,
        completedAchievements: _progress.completedAchievements,
        surahProgress: _progress.surahProgress,
        savedReflections: _progress.savedReflections,
      );
    } else {
      _progress = UserProgressModel(
        totalAyahRead: _progress.totalAyahRead,
        totalDaysStreak: _progress.totalDaysStreak,
        currentStreak: 0,
        lastReadDate: now,
        totalPoints: _progress.totalPoints,
        level: _progress.level,
        completedAchievements: _progress.completedAchievements,
        surahProgress: _progress.surahProgress,
        savedReflections: _progress.savedReflections,
      );
    }
    _saveProgress();
    notifyListeners();
  }

  void addAyahRead(int points) {
    _progress = UserProgressModel(
      totalAyahRead: _progress.totalAyahRead + 1,
      totalDaysStreak: _progress.totalDaysStreak,
      currentStreak: _progress.currentStreak,
      lastReadDate: DateTime.now(),
      totalPoints: _progress.totalPoints + points,
      level: _calculateLevel(_progress.totalPoints + points),
      completedAchievements: _progress.completedAchievements,
      surahProgress: _progress.surahProgress,
      savedReflections: _progress.savedReflections,
    );
    _saveProgress();
    notifyListeners();
  }

  void updateSurahProgress(String surahName, int ayahNumber) {
    final updated = Map<String, int>.from(_progress.surahProgress);
    updated[surahName] = ayahNumber;
    _progress = UserProgressModel(
      totalAyahRead: _progress.totalAyahRead,
      totalDaysStreak: _progress.totalDaysStreak,
      currentStreak: _progress.currentStreak,
      lastReadDate: _progress.lastReadDate,
      totalPoints: _progress.totalPoints,
      level: _progress.level,
      completedAchievements: _progress.completedAchievements,
      surahProgress: updated,
      savedReflections: _progress.savedReflections,
    );
    _saveProgress();
    notifyListeners();
  }

  void addAchievement(String achievementId) {
    if (!_progress.completedAchievements.contains(achievementId)) {
      final updated = List<String>.from(_progress.completedAchievements)
        ..add(achievementId);
      _progress = UserProgressModel(
        totalAyahRead: _progress.totalAyahRead,
        totalDaysStreak: _progress.totalDaysStreak,
        currentStreak: _progress.currentStreak,
        lastReadDate: _progress.lastReadDate,
        totalPoints: _progress.totalPoints + 50,
        level: _calculateLevel(_progress.totalPoints + 50),
        completedAchievements: updated,
        surahProgress: _progress.surahProgress,
        savedReflections: _progress.savedReflections,
      );
      _saveProgress();
      notifyListeners();
    }
  }

  void saveReflection(String ayahReference, String situation) {
    // Check if already saved to avoid duplicates
    final exists = _progress.savedReflections.any(
      (r) => r['ayahReference'] == ayahReference && r['situation'] == situation,
    );

    if (!exists) {
      final updatedReflections =
          List<Map<String, String>>.from(_progress.savedReflections)
            ..add({
              'ayahReference': ayahReference,
              'situation': situation,
              'date': DateTime.now().toIso8601String(),
            });

      // Award points for saving reflection (e.g., 20 points)
      final newPoints = _progress.totalPoints + 20;

      _progress = UserProgressModel(
        totalAyahRead: _progress.totalAyahRead,
        totalDaysStreak: _progress.totalDaysStreak,
        currentStreak: _progress.currentStreak,
        lastReadDate: _progress.lastReadDate,
        totalPoints: newPoints,
        level: _calculateLevel(newPoints),
        completedAchievements: _progress.completedAchievements,
        surahProgress: _progress.surahProgress,
        savedReflections: updatedReflections,
      );
      _saveProgress();
      notifyListeners();
    }
  }

  int _calculateLevel(int points) {
    int level = 1;
    int requiredPoints = 100;
    while (points >= requiredPoints) {
      level++;
      requiredPoints = level * 100;
    }
    return level;
  }
}
