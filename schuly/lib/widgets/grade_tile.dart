import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/theme_provider.dart';

class GradeTile extends StatelessWidget {
  final String subject;
  final String grade;
  final String date;
  final bool confirmed;

  const GradeTile({
    super.key,
    required this.subject,
    required this.grade,
    required this.date,
    required this.confirmed
  });

  String _formatDate(String dateString) {
    try {
      // Try to parse the date string
      DateTime parsedDate;

      // Handle different possible input formats
      if (dateString.contains('-')) {
        // ISO format like "2024-01-15"
        parsedDate = DateTime.parse(dateString);
      } else if (dateString.contains('.')) {
        // Already in Swiss format like "15.01.2024"
        return dateString;
      } else {
        // Fallback to original string if parsing fails
        return dateString;
      }

      // Format to Swiss ISO (DD.MM.YYYY)
      final formatter = DateFormat('dd.MM.yyyy');
      return formatter.format(parsedDate);
    } catch (e) {
      // Return original string if parsing fails
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final surfaceContainer = appColors?.surfaceContainer ??
        Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Grade display - just the number
          Text(
            grade,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(date),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Simple confirmation indicator
          Icon(
            confirmed ? Icons.check_circle_outline : Icons.schedule,
            color: confirmed
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ],
      ),
    );
  }
}