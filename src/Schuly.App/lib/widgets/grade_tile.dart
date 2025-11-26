import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/api_store.dart';
import '../utils/grade_utils.dart';
import 'package:schuly/api/lib/api.dart';
import '../l10n/app_localizations.dart';
import 'animated_grade_card.dart';

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
        Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3);
    final apiStore = Provider.of<ApiStore>(context);

    // Parse grade to double if available
    double? gradeValue;
    if (grade.mark != null) {
      if (grade.mark is num) {
        gradeValue = (grade.mark as num).toDouble();
      } else if (grade.mark is String && (grade.mark as String).isNotEmpty) {
        gradeValue = double.tryParse(grade.mark as String);
      }
    }

    // Always show raw value for individual grades in tiles
    String gradeDisplay;
    if (gradeValue != null) {
      // Show raw value directly
      String rawGrade = gradeValue.toString();
      // Remove trailing .0 if it's a whole number
      if (rawGrade.endsWith('.0')) {
        rawGrade = rawGrade.substring(0, rawGrade.length - 2);
      }
      gradeDisplay = rawGrade;
    } else {
      gradeDisplay = '?';
    }

    return GestureDetector(
      onTap: () => _showGradeDetails(context),
      child: AnimatedGradeCard(
        gradeValue: gradeValue,
        enableFlashyAnimations: apiStore.enableFlashyAnimations,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Grade display - just the number with optional color
              Text(
                gradeDisplay,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: gradeValue != null && apiStore.useGradeColors
                    ? GradeUtils.getGradeColor(gradeValue, apiStore.gradeRedThreshold, apiStore.gradeYellowThreshold, true)
                    : Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      grade.title ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatDate(grade.date ?? ''),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              // Simple confirmation indicator
              Icon(
                (grade.isConfirmed ?? false) ? Icons.check_circle_outline : Icons.schedule,
                color: (grade.isConfirmed ?? false)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                size: 16,
              ),
            ],
          ),
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
    final localizations = AppLocalizations.of(context)!;
    final apiStore = Provider.of<ApiStore>(context);

    // Parse grade to double if available
    double? gradeValue;
    if (grade.mark != null) {
      if (grade.mark is num) {
        gradeValue = (grade.mark as num).toDouble();
      } else if (grade.mark is String && (grade.mark as String).isNotEmpty) {
        gradeValue = double.tryParse(grade.mark as String);
      }
    }

    // Get display text based on mode
    String gradeDisplay;
    if (gradeValue != null) {
      gradeDisplay = GradeUtils.getDisplayGrade(gradeValue, apiStore.gradeDisplayMode);
    } else {
      gradeDisplay = '?';
    }

    return AlertDialog(
      title: Text(
        localizations.gradeDetails,
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
                    color: gradeValue != null && apiStore.useGradeColors
                      ? GradeUtils.getGradeColor(gradeValue, apiStore.gradeRedThreshold, apiStore.gradeYellowThreshold, true).withValues(alpha: 0.15)
                      : Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    gradeDisplay,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: gradeValue != null && apiStore.useGradeColors
                        ? GradeUtils.getGradeColor(gradeValue, apiStore.gradeRedThreshold, apiStore.gradeYellowThreshold, true)
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Basic info
              Text(
                localizations.basicInformation,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('${localizations.titleLabel}:', grade.title ?? '', context),
              _buildDetailRow('${localizations.subjectLabel}:', grade.subject ?? '', context),
              _buildDetailRow('${localizations.courseLabel}:', grade.course ?? '', context),
              _buildDetailRow('${localizations.dateLabel}:', _formatDate(grade.date ?? ''), context),
              _buildDetailRow('${localizations.confirmedLabel}:', (grade.isConfirmed ?? false) ? localizations.yes : localizations.no, context),

              const SizedBox(height: 16),

              // Grade details
              Text(
                localizations.gradeDetails,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('${localizations.gradeLabel}:', gradeDisplay, context),
              if (grade.points != null)
                _buildDetailRow('${localizations.pointsLabel}:', grade.points is num ? grade.points.toString() : (grade.points ?? ''), context),
              _buildDetailRow('${localizations.weightLabel}:', grade.weight is num ? grade.weight.toString() : (grade.weight ?? 'N/A'), context),
              _buildDetailRow('${localizations.courseGradeLabel}:', grade.courseGrade != null && grade.courseGrade!.isNotEmpty
                ? (double.tryParse(grade.courseGrade!) != null
                  ? GradeUtils.getDisplayGrade(double.parse(grade.courseGrade!), apiStore.gradeDisplayMode)
                  : grade.courseGrade!)
                : '?', context),

              if (grade.examinationGroups != null && grade.examinationGroups!.averageExamGroup != null) ...[
                const SizedBox(height: 16),
                Text(
                  localizations.classAverage,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                if (grade.examinationGroups!.examGroup != null)
                  _buildDetailRow('${localizations.examGroupLabel}:', grade.examinationGroups!.examGroup, context),
                _buildDetailRow('${localizations.classAverageLabel}:', grade.examinationGroups!.averageExamGroup, context),
                if (grade.examinationGroups!.weightExamGroup != null)
                  _buildDetailRow('${localizations.groupWeightLabel}:', grade.examinationGroups!.weightExamGroup, context),
              ],

              if (grade.comment != null && grade.comment!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  localizations.commentLabel,
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
          child: Text(localizations.close),
        ),
      ],
    );
  }
}