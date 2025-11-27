import 'package:flutter/material.dart';
import '../../core/services/audio_service.dart';
import '../../core/l10n/app_strings.dart';

class AudioDownloadDialog extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const AudioDownloadDialog({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<AudioDownloadDialog> createState() => _AudioDownloadDialogState();
}

class _AudioDownloadDialogState extends State<AudioDownloadDialog> {
  final AudioPlayerService _audioService = AudioPlayerService();
  bool _isDownloading = false;
  bool _downloadComplete = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkDownloadStatus();
  }

  Future<void> _checkDownloadStatus() async {
    final isDownloaded =
        await _audioService.isAudioDownloaded(widget.surahNumber);
    if (isDownloaded && mounted) {
      setState(() {
        _downloadComplete = true;
      });
    }
  }

  Future<void> _startDownload() async {
    setState(() {
      _isDownloading = true;
      _errorMessage = null;
    });

    try {
      await _audioService.downloadSurah(widget.surahNumber);

      if (mounted) {
        setState(() {
          _isDownloading = false;
          _downloadComplete = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _cancelDownload() {
    _audioService.cancelDownload();
    if (mounted) {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _downloadComplete ? Icons.check_circle : Icons.download,
                size: 48,
                color: _downloadComplete ? Colors.green : Colors.teal,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              _downloadComplete
                  ? AppStrings.get(context, 'audioDownloadComplete')
                  : AppStrings.get(context, 'downloadAudio'),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Surah name
            Text(
              widget.surahName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Description
            if (!_downloadComplete && !_isDownloading)
              Text(
                AppStrings.get(context, 'downloadPrompt'),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

            // Error message
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),

            // Progress indicator
            if (_isDownloading)
              Column(
                children: [
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.get(context, 'audioDownloading'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

            // Completion message
            if (_downloadComplete)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Audio telah tersedia untuk diputar secara offline',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel/Close button
                TextButton(
                  onPressed: () {
                    if (_isDownloading) {
                      _cancelDownload();
                    }
                    Navigator.of(context).pop(_downloadComplete);
                  },
                  child: Text(
                    _isDownloading
                        ? AppStrings.get(context, 'cancelDownload')
                        : AppStrings.get(context, 'close'),
                  ),
                ),
                const SizedBox(width: 8),

                // Download/Play button
                if (!_isDownloading)
                  ElevatedButton(
                    onPressed: _downloadComplete ? null : _startDownload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      _downloadComplete
                          ? AppStrings.get(context, 'audioDownloadComplete')
                          : AppStrings.get(context, 'download'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the dialog
Future<bool?> showAudioDownloadDialog({
  required BuildContext context,
  required int surahNumber,
  required String surahName,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AudioDownloadDialog(
      surahNumber: surahNumber,
      surahName: surahName,
    ),
  );
}
