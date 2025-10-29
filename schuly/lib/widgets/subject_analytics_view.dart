import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schuly/api/lib/api.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/api_store.dart';
import '../utils/grade_utils.dart';

class SubjectAnalyticsView extends StatelessWidget {
  final String subjectName;
  final List<GradeDto> subjectGrades;

  const SubjectAnalyticsView({
    super.key,
    required this.subjectName,
    required this.subjectGrades,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        // Calculate weighted average
        final average = GradeUtils.calculateWeightedAverage(subjectGrades);

        // Sort by date
        final sortedGrades = List<GradeDto>.from(subjectGrades);
        sortedGrades.sort((a, b) {
          final dateA = DateTime.tryParse(a.date);
          final dateB = DateTime.tryParse(b.date);
          if (dateA == null || dateB == null) return 0;
          return dateA.compareTo(dateB);
        });

        return Scaffold(
          appBar: AppBar(
            title: Text(subjectName),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject Average Card
                _buildAverageCard(context, average, apiStore),
                const SizedBox(height: 16),

                // Historical Chart
                if (sortedGrades.length > 1)
                  _buildHistoricalChart(context, sortedGrades),
                if (sortedGrades.length > 1)
                  const SizedBox(height: 16),

                // Grade List with Weightings
                _buildGradesList(context, sortedGrades, apiStore),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAverageCard(BuildContext context, double? average, ApiStore apiStore) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Large grade display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: average != null && apiStore.useGradeColors
                    ? GradeUtils.getGradeColor(
                        average,
                        apiStore.gradeRedThreshold,
                        apiStore.gradeYellowThreshold,
                        true,
                      ).withValues(alpha: 0.15)
                    : Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Text(
                average != null
                    ? GradeUtils.getDisplayGrade(
                        average,
                        apiStore.gradeDisplayMode,
                      )
                    : '?',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: average != null && apiStore.useGradeColors
                      ? GradeUtils.getGradeColor(
                          average,
                          apiStore.gradeRedThreshold,
                          apiStore.gradeYellowThreshold,
                          true,
                        )
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 24),
            // Grade information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subject Average',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subjectName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${subjectGrades.length} grades',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoricalChart(BuildContext context, List<GradeDto> sortedGrades) {
    // Convert grades to FlSpot points
    final spots = <FlSpot>[];
    for (int i = 0; i < sortedGrades.length; i++) {
      final gradeValue = double.tryParse(sortedGrades[i].mark ?? '0') ?? 0;
      if (gradeValue != 0) {
        spots.add(FlSpot(i.toDouble(), gradeValue));
      }
    }

    if (spots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade Progression',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.3),
                        strokeWidth: 0.8,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          );
                        },
                        reservedSize: 28,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < sortedGrades.length) {
                            final dateStr = sortedGrades[index].date;
                            try {
                              final date = DateTime.parse(dateStr);
                              return Text(
                                '${date.day}',
                                style: Theme.of(context).textTheme.labelSmall,
                              );
                            } catch (e) {
                              return const SizedBox.shrink();
                            }
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 28,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 2,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Theme.of(context).colorScheme.primary,
                            strokeWidth: 2,
                            strokeColor: Theme.of(context).colorScheme.surface,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                  minY: 1.0,
                  maxY: 6.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradesList(BuildContext context, List<GradeDto> sortedGrades, ApiStore apiStore) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Grades',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...sortedGrades.map((grade) {
              final gradeValue = double.tryParse(grade.mark ?? '0') ?? 0;
              final weight = double.tryParse(grade.weight) ?? 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            grade.title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                grade.date,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 16),
                              if (weight > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Weight: ${weight.toStringAsFixed(1)}',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (gradeValue != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: apiStore.useGradeColors
                              ? GradeUtils.getGradeColor(
                                  gradeValue,
                                  apiStore.gradeRedThreshold,
                                  apiStore.gradeYellowThreshold,
                                  true,
                                ).withValues(alpha: 0.15)
                              : Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: apiStore.useGradeColors
                              ? Border.all(
                                  color: GradeUtils.getGradeColor(
                                    gradeValue,
                                    apiStore.gradeRedThreshold,
                                    apiStore.gradeYellowThreshold,
                                    true,
                                  ).withValues(alpha: 0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Text(
                          GradeUtils.getDisplayGrade(gradeValue, apiStore.gradeDisplayMode),
                          style: TextStyle(
                            color: apiStore.useGradeColors
                                ? GradeUtils.getGradeColor(
                                    gradeValue,
                                    apiStore.gradeRedThreshold,
                                    apiStore.gradeYellowThreshold,
                                    true,
                                  )
                                : Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
