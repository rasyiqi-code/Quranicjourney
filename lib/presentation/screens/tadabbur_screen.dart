import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/tadabbur_provider.dart';
import '../../core/models/tadabbur_model.dart';
import '../../core/models/tafsir_model.dart';
import '../../core/providers/language_provider.dart';
import '../widgets/page_transition.dart';
import '../theme/app_theme.dart';
import 'tadabbur_detail_screen.dart';

class TadabburScreen extends StatefulWidget {
  const TadabburScreen({super.key});

  @override
  State<TadabburScreen> createState() => _TadabburScreenState();
}

class _TadabburScreenState extends State<TadabburScreen> {
  @override
  Widget build(BuildContext context) {
    final languageCode =
        Provider.of<LanguageProvider>(context).currentLocale.languageCode;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryGreen,
                AppTheme.darkGreen,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 48,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          languageCode == 'en' ? 'Tadabbur Mode' : 'Mode Tadabbur',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<TadabburProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageCode == 'en'
                      ? 'Choose Your Life Situation'
                      : 'Pilih Situasi Kehidupan Anda',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  languageCode == 'en'
                      ? 'Find Quran verses that relate to your current situation'
                      : 'Temukan ayat Al-Qur\'an yang sesuai dengan situasi Anda saat ini',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSituationGrid(context, provider, languageCode),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSituationGrid(
    BuildContext context,
    TadabburProvider provider,
    String languageCode,
  ) {
    const situations = LifeSituation.values;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: situations.length,
      itemBuilder: (context, index) {
        final situation = situations[index];
        final tadabbur = TadabburModel(
          ayahReference: '',
          situation: situation,
          connection: '',
          reflection: '',
          tafsir: TafsirModel(
            ayahReference: '',
            shortTafsir: '',
            detailedTafsir: '',
            keyPoints: [],
          ),
          keyPoints: [],
        );

        return Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                provider.loadTadabburForSituation(situation);
                if (provider.currentTadabbur != null) {
                  Navigator.push(
                    context,
                    PageTransitions.slideRoute(
                      TadabburDetailScreen(
                        tadabbur: provider.currentTadabbur!,
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getSituationIcon(situation),
                      size: 36,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      tadabbur.situationLabel(languageCode),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getSituationIcon(LifeSituation situation) {
    switch (situation) {
      case LifeSituation.sedih:
        return Icons.sentiment_dissatisfied_rounded;
      case LifeSituation.bingung:
        return Icons.help_outline_rounded;
      case LifeSituation.bersyukur:
        return Icons.celebration_rounded;
      case LifeSituation.takut:
        return Icons.warning_rounded;
      case LifeSituation.marah:
        return Icons.mood_bad_rounded;
      case LifeSituation.bahagia:
        return Icons.mood_rounded;
      case LifeSituation.khawatir:
        return Icons.psychology_rounded;
      case LifeSituation.putusAsa:
        return Icons.heart_broken_rounded;
      case LifeSituation.bangga:
        return Icons.emoji_events_rounded;
      case LifeSituation.cemas:
        return Icons.psychology_alt_rounded;
      case LifeSituation.sakit:
        return Icons.medical_services_rounded;
      case LifeSituation.kehilanganOrang:
        return Icons.sentiment_very_dissatisfied_rounded;
      case LifeSituation.stress:
        return Icons.mood_bad_outlined;
      case LifeSituation.sendiri:
        return Icons.person_outline_rounded;
      case LifeSituation.sukses:
        return Icons.star_rounded;
      case LifeSituation.gagal:
        return Icons.trending_down_rounded;
      case LifeSituation.iri:
        return Icons.remove_red_eye_outlined;
      case LifeSituation.berdosa:
        return Icons.warning_amber_rounded;
      case LifeSituation.tobat:
        return Icons.favorite_border_rounded;
      case LifeSituation.lemah:
        return Icons.battery_0_bar_rounded;
      case LifeSituation.kuat:
        return Icons.battery_full_rounded;
      case LifeSituation.ragu:
        return Icons.question_mark_rounded;
      case LifeSituation.yakin:
        return Icons.check_circle_outline_rounded;
      case LifeSituation.gelisah:
        return Icons.waves_rounded;
      case LifeSituation.tenang:
        return Icons.spa_rounded;
      case LifeSituation.lelah:
        return Icons.battery_alert_rounded;
      case LifeSituation.kecewa:
        return Icons.sentiment_dissatisfied_rounded;
      case LifeSituation.rindu:
        return Icons.favorite_rounded;
      case LifeSituation.hutang:
        return Icons.money_off_rounded;
      case LifeSituation.difitnah:
        return Icons.record_voice_over_rounded;
    }
  }
}
