class UserProgressModel {
  final int totalAyahRead;
  final int totalDaysStreak;
  final int currentStreak;
  final DateTime lastReadDate;
  final int totalPoints;
  final int level;
  final List<String> completedAchievements;
  final Map<String, int> surahProgress;
  final List<Map<String, String>> savedReflections;

  UserProgressModel({
    required this.totalAyahRead,
    required this.totalDaysStreak,
    required this.currentStreak,
    required this.lastReadDate,
    required this.totalPoints,
    required this.level,
    required this.completedAchievements,
    required this.surahProgress,
    required this.savedReflections,
  });

  factory UserProgressModel.initial() {
    return UserProgressModel(
      totalAyahRead: 0,
      totalDaysStreak: 0,
      currentStreak: 0,
      lastReadDate: DateTime.now(),
      totalPoints: 0,
      level: 1,
      completedAchievements: [],
      surahProgress: {},
      savedReflections: [],
    );
  }

  factory UserProgressModel.fromJson(Map<String, dynamic> json) {
    return UserProgressModel(
      totalAyahRead: json['total_ayah_read'] as int? ?? 0,
      totalDaysStreak: json['total_days_streak'] as int? ?? 0,
      currentStreak: json['current_streak'] as int? ?? 0,
      lastReadDate: DateTime.parse(json['last_read_date'] as String),
      totalPoints: json['total_points'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      completedAchievements: (json['completed_achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      surahProgress: (json['surah_progress'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, value as int)) ??
          {},
      savedReflections: (json['saved_reflections'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_ayah_read': totalAyahRead,
      'total_days_streak': totalDaysStreak,
      'current_streak': currentStreak,
      'last_read_date': lastReadDate.toIso8601String(),
      'total_points': totalPoints,
      'level': level,
      'completed_achievements': completedAchievements,
      'surah_progress': surahProgress,
      'saved_reflections': savedReflections,
    };
  }

  int get pointsToNextLevel => (level * 100) - totalPoints;
  double get levelProgress => totalPoints / (level * 100);
}
