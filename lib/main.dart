import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'core/providers/user_progress_provider.dart';
import 'core/providers/tadabbur_provider.dart';
import 'core/providers/funfact_provider.dart';
import 'core/providers/bookmark_provider.dart';
import 'core/providers/language_provider.dart';
import 'core/providers/onboarding_provider.dart';
import 'core/services/funfact_service.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // Setup Gemini API Key (dari environment variable atau shared preferences)
  const geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
  if (geminiApiKey.isNotEmpty) {
    FunfactService().setGeminiApiKey(geminiApiKey);
    await prefs.setString('gemini_api_key', geminiApiKey);
  } else {
    // Coba ambil dari shared preferences jika sudah pernah disimpan
    final savedApiKey = prefs.getString('gemini_api_key');
    if (savedApiKey != null && savedApiKey.isNotEmpty) {
      FunfactService().setGeminiApiKey(savedApiKey);
    } else {
      // Set default API key yang diberikan user
      const defaultApiKey = 'AIzaSyAnnLlHgijm7D1c0wnbZVSL00N4j2-uGHE';
      FunfactService().setGeminiApiKey(defaultApiKey);
      await prefs.setString('gemini_api_key', defaultApiKey);
    }
  }

  // Enable wakelock to keep screen awake while app is running
  await WakelockPlus.enable();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProgressProvider(prefs)),
        ChangeNotifierProvider(create: (_) => TadabburProvider()),
        ChangeNotifierProvider(create: (_) => FunfactProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider(prefs)),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider(prefs)),
      ],
      child: const QuranicJourneyApp(),
    ),
  );
}

class QuranicJourneyApp extends StatelessWidget {
  const QuranicJourneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, OnboardingProvider>(
      builder: (context, languageProvider, onboardingProvider, child) {
        return MaterialApp(
          title: 'Quranic Journey',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          locale: languageProvider.currentLocale,
          supportedLocales: const [
            Locale('id'),
            Locale('en'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: onboardingProvider.hasCompletedOnboarding
              ? const HomeScreen()
              : const OnboardingScreen(),
        );
      },
    );
  }
}
