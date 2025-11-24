import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/user_progress_provider.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProgressProvider>(
      builder: (context, provider, child) {
        final progress = provider.progress;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress Anda',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Level ${progress.level}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 300) {
                      // Single column for narrow screens
                      return Column(
                        children: [
                          _buildStatItem(
                            context,
                            Icons.menu_book,
                            'Ayat Dibaca',
                            '${progress.totalAyahRead}',
                          ),
                          const SizedBox(height: 16),
                          _buildStatItem(
                            context,
                            Icons.local_fire_department,
                            'Streak',
                            '${progress.currentStreak} hari',
                          ),
                          const SizedBox(height: 16),
                          _buildStatItem(
                            context,
                            Icons.star,
                            'Poin',
                            '${progress.totalPoints}',
                          ),
                        ],
                      );
                    }
                    // Row for wider screens
                    return Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            context,
                            Icons.menu_book,
                            'Ayat Dibaca',
                            '${progress.totalAyahRead}',
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            context,
                            Icons.local_fire_department,
                            'Streak',
                            '${progress.currentStreak} hari',
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            context,
                            Icons.star,
                            'Poin',
                            '${progress.totalPoints}',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Progress ke Level ${progress.level + 1}',
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${progress.totalPoints}/${progress.level * 100}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress.levelProgress.clamp(0.0, 1.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}

