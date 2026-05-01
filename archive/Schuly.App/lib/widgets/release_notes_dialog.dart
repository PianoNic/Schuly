import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../l10n/app_localizations.dart';
import '../models/release_note.dart';
import '../services/release_notes_service.dart';
import '../pages/release_notes_page.dart';

class ReleaseNotesDialog extends StatelessWidget {
  final List<ReleaseNote> releaseNotes;

  const ReleaseNotesDialog({
    super.key,
    required this.releaseNotes,
  });

  static Future<void> showIfNeeded(BuildContext context) async {
    final shouldShow = await ReleaseNotesService.shouldShowReleaseNotesOnStart();
    if (!shouldShow || !context.mounted) return;

    final newReleaseNotes = await ReleaseNotesService.getNewReleaseNotes();
    if (newReleaseNotes.isEmpty || !context.mounted) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ReleaseNotesDialog(releaseNotes: newReleaseNotes),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final latestNote = releaseNotes.first;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.celebration,
            color: theme.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.whatsNew),
                Text(
                  AppLocalizations.of(context)!.versionWithNumber(latestNote.version, ''),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 300),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Latest release info
              Text(
                latestNote.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              // Markdown content
              MarkdownBody(
                data: latestNote.description,
                selectable: true,
                styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                  p: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                  h1: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  h2: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  h3: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                  listBullet: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (releaseNotes.length > 1)
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ReleaseNotesPage(),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.showAll),
                ),
              ),
            if (releaseNotes.length > 1) const SizedBox(width: 8),
            Expanded(
              child: FilledButton(
                onPressed: () async {
                  await ReleaseNotesService.markReleaseNotesAsSeen();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
            ),
          ],
        ),
      ],
    );
  }

}