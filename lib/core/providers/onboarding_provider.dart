import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  static const String _onboardingKey = 'has_completed_onboarding';
  final SharedPreferences _prefs;
  bool _hasCompletedOnboarding = false;

  OnboardingProvider(this._prefs) {
    _loadOnboardingStatus();
  }

  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  Future<void> _loadOnboardingStatus() async {
    _hasCompletedOnboarding = _prefs.getBool(_onboardingKey) ?? false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _hasCompletedOnboarding = true;
    await _prefs.setBool(_onboardingKey, true);
    notifyListeners();
  }

  Future<void> resetOnboarding() async {
    _hasCompletedOnboarding = false;
    await _prefs.setBool(_onboardingKey, false);
    notifyListeners();
  }
}
