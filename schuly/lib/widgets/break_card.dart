import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class BreakCard extends StatelessWidget {
  final int duration; // Duration in minutes
  final DateTime? startTime;
  final DateTime? endTime;

  const BreakCard({
    super.key,
    required this.duration,
    this.startTime,
    this.endTime,
  });

  bool get isCurrentBreak {
    if (startTime == null || endTime == null) return false;
    final now = DateTime.now();
    return now.isAfter(startTime!) && now.isBefore(endTime!);
  }

  bool get isLunchBreak {
    if (startTime == null || endTime == null) return false;
    if (duration < 30) return false; // Must be at least 30 minutes

    final startHour = startTime!.hour;
    final startMinute = startTime!.minute;
    final endHour = endTime!.hour;
    final endMinute = endTime!.minute;

    // Check if break starts between 11:00-13:00 or 11:30-12:30
    final startInLunchTime = (startHour == 11 && startMinute >= 0) ||
                             (startHour == 12) ||
                             (startHour == 13 && startMinute == 0);

    // Check if break ends between 11:30-13:30
    final endInLunchTime = (endHour == 11 && endMinute >= 30) ||
                           (endHour == 12) ||
                           (endHour == 13 && endMinute <= 30);

    return startInLunchTime && endInLunchTime;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Use primary container color for current break, similar to lesson highlighting
    final backgroundColor = isCurrentBreak
        ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.8)
        : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.2);

    final borderColor = isCurrentBreak
        ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)
        : Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor,
          width: isCurrentBreak ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isLunchBreak ? Icons.restaurant : Icons.coffee,
            size: 14,
            color: isCurrentBreak
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 6),
          Text(
            '${isLunchBreak ? localizations.lunchBreak : localizations.lessonBreak} ($duration min)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isCurrentBreak
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              fontWeight: isCurrentBreak ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}