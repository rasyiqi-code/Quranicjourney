import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/providers/user_progress_provider.dart';
import '../theme/app_theme.dart';

class ModernProgressCard extends StatelessWidget {
  const ModernProgressCard({super.key});

  // Helper function to determine next milestone
  int _getNextMilestone(int ayahRead) {
    const milestones = [10, 25, 50, 100, 250, 500, 1000, 2500, 5000, 6236];
    for (var milestone in milestones) {
      if (ayahRead < milestone) return milestone;
    }
    return 6236; // Total ayat in Quran
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProgressProvider>(
      builder: (context, provider, child) {
        final progress = provider.progress;
        final nextMilestone = _getNextMilestone(progress.totalAyahRead);
        final progressToMilestone = progress.totalAyahRead / nextMilestone;

        return Container(
          decoration: AppTheme.gradientDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: 24,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.menu_book_rounded,
                      AppStrings.get(context, 'ayah'),
                      '${progress.totalAyahRead}',
                      0,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0),
                          Colors.white.withValues(alpha: 0.3),
                          Colors.white.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.local_fire_department_rounded,
                      AppStrings.get(context, 'streak'),
                      '${progress.currentStreak}',
                      1,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0),
                          Colors.white.withValues(alpha: 0.3),
                          Colors.white.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showPointsDisclaimer(context),
                      child: _buildStatItem(
                        context,
                        Icons.star_rounded,
                        AppStrings.get(context, 'points'),
                        '${progress.totalPoints}',
                        2,
                        showInfo: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0),
                      Colors.white.withValues(alpha: 0.3),
                      Colors.white.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.get(context, 'progressToLevel'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        '${progress.totalAyahRead}/$nextMilestone',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progressToMilestone.clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.goldAccent),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 300.ms)
                      .slideX(begin: -0.2, end: 0),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    int delay, {
    bool showInfo = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: (delay * 100).ms)
                .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
            if (showInfo)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppTheme.goldAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info_rounded,
                    color: Colors.white,
                    size: 10,
                  ),
                ).animate().fadeIn(delay: 600.ms),
              ),
          ],
        ),
        const SizedBox(height: 6),
        TweenAnimationBuilder<int>(
          duration: Duration(milliseconds: 1000 + (delay * 200)),
          tween: IntTween(begin: 0, end: int.tryParse(value) ?? 0),
          builder: (context, count, child) {
            return Text(
              '$count',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            );
          },
        ).animate().fadeIn(duration: 400.ms, delay: (delay * 100 + 200).ms),
        const SizedBox(height: 3),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ).animate().fadeIn(duration: 400.ms, delay: (delay * 100 + 300).ms),
      ],
    );
  }

  void _showPointsDisclaimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.info_outline_rounded, color: AppTheme.primaryGreen),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Tentang Pahala Kebaikan',
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDisclaimerItem(
                'Simulasi Motivasi',
                'Pahala yang ditampilkan adalah representasi visual untuk memotivasi Anda (1 huruf = 10 pahala simbolis), bukan nilai pahala pasti di sisi Allah SWT.',
              ),
              const SizedBox(height: 12),
              _buildDisclaimerItem(
                'Niat Ibadah',
                'Jadikan ridha Allah sebagai tujuan utama membaca Al-Qur\'an, bukan sekadar mengumpulkan pahala simbolis aplikasi.',
              ),
              const SizedBox(height: 12),
              _buildDisclaimerItem(
                'Pahala Sesungguhnya',
                'Pahala yang sebenarnya hanya diketahui Allah dan bisa berlipat ganda tergantung keikhlasan dan kekhusyukan.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Mengerti',
              style: TextStyle(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
