import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';

class LessonTile extends StatelessWidget {
  final String day;
  final String time;
  final String subject;
  final String room;
  final String teacher;
  final DateTime? startTime;
  final DateTime? endTime;

  const LessonTile({
    super.key,
    required this.day,
    required this.time,
    required this.subject,
    required this.room,
    required this.teacher,
    this.startTime,
    this.endTime,
  });

  bool get isCurrentLesson {
    if (startTime == null || endTime == null) return false;
    final now = DateTime.now();
    return now.isAfter(startTime!) && now.isBefore(endTime!);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final surfaceContainer = appColors?.surfaceContainer ??
        Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3);

    // Use darker background for current lesson
    final backgroundColor = isCurrentLesson
        ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
        : surfaceContainer;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('$room • $teacher'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}