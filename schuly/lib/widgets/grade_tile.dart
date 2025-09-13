import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/theme_provider.dart';
import 'package:schuly/api/lib/api.dart';

class GradeTile extends StatelessWidget {
  final GradeDto grade;

  const GradeTile({
    super.key,
    required this.grade,
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

  void _showGradeDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => GradeDetailsDialog(grade: grade),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final surfaceContainer = appColors?.surfaceContainer ??
        Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3);

    return GestureDetector(
      onTap: () => _showGradeDetails(context),
      child: Container(
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
              grade.mark,
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
                    grade.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(grade.date),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Simple confirmation indicator
            Icon(
              grade.isConfirmed ? Icons.check_circle_outline : Icons.schedule,
              color: grade.isConfirmed
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class GradeDetailsDialog extends StatelessWidget {
  final GradeDto grade;

  const GradeDetailsDialog({
    super.key,
    required this.grade,
  });

  String _formatDate(String dateString) {
    try {
      DateTime parsedDate;
      if (dateString.contains('-')) {
        parsedDate = DateTime.parse(dateString);
      } else if (dateString.contains('.')) {
        return dateString;
      } else {
        return dateString;
      }
      final formatter = DateFormat('dd.MM.yyyy');
      return formatter.format(parsedDate);
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildDetailRow(String label, String? value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Notendetails',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Grade display
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    grade.mark,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Basic info
              Text(
                'Grundinformationen',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('Titel:', grade.title, context),
              _buildDetailRow('Fach:', grade.subject, context),
              _buildDetailRow('Kurs:', grade.course, context),
              _buildDetailRow('Datum:', _formatDate(grade.date), context),
              _buildDetailRow('Bestätigt:', grade.isConfirmed ? 'Ja' : 'Nein', context),

              const SizedBox(height: 16),

              // Grade details
              Text(
                'Notendetails',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('Note:', grade.mark, context),
              if (grade.points != null)
                _buildDetailRow('Punkte:', grade.points, context),
              _buildDetailRow('Gewichtung:', grade.weight, context),
              _buildDetailRow('Kursnote:', grade.courseGrade, context),

              if (grade.examinationGroups.averageExamGroup != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Klassenschnitt',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                if (grade.examinationGroups.examGroup != null)
                  _buildDetailRow('Prüfungsgruppe:', grade.examinationGroups.examGroup, context),
                _buildDetailRow('Klassenschnitt:', grade.examinationGroups.averageExamGroup, context),
                if (grade.examinationGroups.weightExamGroup != null)
                  _buildDetailRow('Gruppengewichtung:', grade.examinationGroups.weightExamGroup, context),
              ],

              if (grade.comment != null && grade.comment!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Kommentar',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  grade.comment!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Schließen'),
        ),
      ],
    );
  }
}