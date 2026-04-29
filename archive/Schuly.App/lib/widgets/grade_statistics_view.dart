import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schuly/api/lib/api.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/api_store.dart';
import '../utils/grade_utils.dart';
import '../l10n/app_localizations.dart';
import 'subject_analytics_view.dart';

class GradeStatisticsView extends StatelessWidget {
  final List<GradeDto> grades;

  const GradeStatisticsView({
    super.key,
    required this.grades,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Overall Average Card
              _buildOverallAverageCard(context, apiStore),
              const SizedBox(height: 16),

              // Subject Ranking Card
              _buildSubjectRankingCard(context, apiStore),
              const SizedBox(height: 16),

              // Grade Progression Chart
              _buildGradeProgressionChart(context, apiStore),
              const SizedBox(height: 16),

              // Grade Distribution Card
              _buildGradeDistributionCard(context),
              const SizedBox(height: 16),

              // Statistics Summary Card
              _buildStatisticsSummaryCard(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverallAverageCard(BuildContext context, ApiStore apiStore) {
    // Group grades by subject for overall average calculation
    final Map<String, List<GradeDto>> gradesBySubject = {};
    for (final grade in grades) {
      gradesBySubject.putIfAbsent(grade.subject ?? '', () => []).add(grade);
    }

    final overallAverage = GradeUtils.calculateOverallAverage(gradesBySubject);
    final localizations = AppLocalizations.of(context)!;

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
                color: overallAverage != null && apiStore.useGradeColors
                    ? GradeUtils.getGradeColor(
                        overallAverage,
                        apiStore.gradeRedThreshold,
                        apiStore.gradeYellowThreshold,
                        true,
                      ).withValues(alpha: 0.15)
                    : Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Text(
                overallAverage != null
                    ? GradeUtils.getDisplayGrade(
                        overallAverage,
                        apiStore.gradeDisplayMode,
                      )
                    : '?',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: overallAverage != null && apiStore.useGradeColors
                      ? GradeUtils.getGradeColor(
                          overallAverage,
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
                    localizations.grades,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Overall Average',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${grades.length} ${localizations.grades.toLowerCase()}',
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

  Widget _buildSubjectRankingCard(BuildContext context, ApiStore apiStore) {
    final localizations = AppLocalizations.of(context)!;

    // Group by subject and calculate averages
    final Map<String, List<GradeDto>> gradesBySubject = {};
    for (final grade in grades) {
      gradesBySubject.putIfAbsent(grade.subject ?? '', () => []).add(grade);
    }

    // Calculate averages and sort
    final subjectAverages = <MapEntry<String, double>>[];
    for (final entry in gradesBySubject.entries) {
      final average = GradeUtils.calculateWeightedAverage(entry.value);
      if (average != null) {
        subjectAverages.add(MapEntry(entry.key, average));
      }
    }
    // Sort by grade value (descending - 6.0 is best)
    subjectAverages.sort((a, b) => b.value.compareTo(a.value));

    if (subjectAverages.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Text(localizations.noGradesFound),
          ),
        ),
      );
    }

    // Split subjects into categories
    final bestSubjects = subjectAverages.where((entry) => entry.value > 4.0).toList();
    final improvementSubjects = subjectAverages.where((entry) => entry.value <= 4.0).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject Rankings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Best subjects (above 4.0)
            if (bestSubjects.isNotEmpty) ...[
              Text(
                'Best Subjects',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              ...bestSubjects.map((entry) {
                final subjectGrades = gradesBySubject[entry.key] ?? [];
                return _buildSubjectRankingRow(
                  context,
                  entry.key,
                  entry.value,
                  apiStore,
                  subjectGrades,
                );
              }),
              const SizedBox(height: 16),
            ],
            // Areas for improvement (below 4.0)
            if (improvementSubjects.isNotEmpty) ...[
              Text(
                'Areas for Improvement',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
              ...improvementSubjects.map((entry) {
                final subjectGrades = gradesBySubject[entry.key] ?? [];
                return _buildSubjectRankingRow(
                  context,
                  entry.key,
                  entry.value,
                  apiStore,
                  subjectGrades,
                );
              }),
            ] else if (bestSubjects.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Keep working on your grades!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectRankingRow(
    BuildContext context,
    String subject,
    double average,
    ApiStore apiStore,
    List<GradeDto> subjectGrades,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubjectAnalyticsView(
                  subjectName: subject,
                  subjectGrades: subjectGrades,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: apiStore.useGradeColors
                        ? GradeUtils.getGradeColor(
                            average,
                            apiStore.gradeRedThreshold,
                            apiStore.gradeYellowThreshold,
                            true,
                          ).withValues(alpha: 0.15)
                        : Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: apiStore.useGradeColors
                        ? Border.all(
                            color: GradeUtils.getGradeColor(
                              average,
                              apiStore.gradeRedThreshold,
                              apiStore.gradeYellowThreshold,
                              true,
                            ).withValues(alpha: 0.3),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Text(
                    GradeUtils.getDisplayGrade(average, apiStore.gradeDisplayMode),
                    style: TextStyle(
                      color: apiStore.useGradeColors
                          ? GradeUtils.getGradeColor(
                              average,
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
          ),
        ),
      ),
    );
  }

  Widget _buildGradeDistributionCard(BuildContext context) {
    // Calculate distribution of grades
    final distribution = {
      '1.0 - 1.9': 0,
      '2.0 - 2.9': 0,
      '3.0 - 3.9': 0,
      '4.0 - 4.9': 0,
      '5.0 - 5.9': 0,
      '6.0': 0,
    };

    for (final grade in grades) {
      double gradeValue = 0;
      if (grade.mark != null) {
        gradeValue = (grade.mark as num).toDouble();
      }
      // Skip grades with value 0 (not available yet)
      if (gradeValue == 0) continue;

      if (gradeValue < 2.0) {
        distribution['1.0 - 1.9'] = distribution['1.0 - 1.9']! + 1;
      } else if (gradeValue < 3.0) {
        distribution['2.0 - 2.9'] = distribution['2.0 - 2.9']! + 1;
      } else if (gradeValue < 4.0) {
        distribution['3.0 - 3.9'] = distribution['3.0 - 3.9']! + 1;
      } else if (gradeValue < 5.0) {
        distribution['4.0 - 4.9'] = distribution['4.0 - 4.9']! + 1;
      } else if (gradeValue < 6.0) {
        distribution['5.0 - 5.9'] = distribution['5.0 - 5.9']! + 1;
      } else {
        distribution['6.0'] = distribution['6.0']! + 1;
      }
    }

    final maxCount = distribution.values.reduce((a, b) => a > b ? a : b);

    // If all grades are 0 (unavailable), return empty
    if (maxCount == 0) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade Distribution',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...distribution.entries.map((entry) {
              final percentage = maxCount > 0 ? (entry.value / maxCount) : 0.0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percentage,
                          minHeight: 8,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            entry.key == '6.0'
                                ? Colors.green
                                : entry.key == '1.0 - 1.9'
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 30,
                      child: Text(
                        '${entry.value}',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.right,
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

  Widget _buildStatisticsSummaryCard(BuildContext context) {
    // Find best and worst grades
    double? bestGrade;
    double? worstGrade;
    String? bestGradeSubject;
    String? worstGradeSubject;

    for (final grade in grades) {
      double? gradeValue;
      if (grade.mark != null) {
        gradeValue = (grade.mark as num).toDouble();
      }
      if (gradeValue != null && gradeValue != 0) {
        // Best grade is the highest value (6 is best in Swiss system)
        if (bestGrade == null || gradeValue > bestGrade) {
          bestGrade = gradeValue;
          bestGradeSubject = grade.subject;
        }
        // Worst grade is the lowest value (1 is worst in Swiss system)
        if (worstGrade == null || gradeValue < worstGrade) {
          worstGrade = gradeValue;
          worstGradeSubject = grade.subject;
        }
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow(
              context,
              'Total Grades',
              '${grades.length}',
              Icons.list,
            ),
            const SizedBox(height: 12),
            if (bestGrade != null)
              _buildSummaryRow(
                context,
                'Best Grade',
                '$bestGrade in $bestGradeSubject',
                Icons.trending_up,
              ),
            const SizedBox(height: 12),
            if (worstGrade != null)
              _buildSummaryRow(
                context,
                'Lowest Grade',
                '$worstGrade in $worstGradeSubject',
                Icons.trending_down,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGradeProgressionChart(BuildContext context, ApiStore apiStore) {
    // Sort grades by date and filter out grades with value 0
    final sortedGrades = List<GradeDto>.from(grades)
        .where((grade) {
          double markValue = 0;
          if (grade.mark != null) {
            markValue = (grade.mark as num).toDouble();
          }
          return markValue != 0;
        })
        .toList();

    sortedGrades.sort((a, b) {
      final dateA = a.date != null ? DateTime.tryParse(a.date!) : null;
      final dateB = b.date != null ? DateTime.tryParse(b.date!) : null;
      if (dateA == null || dateB == null) return 0;
      return dateA.compareTo(dateB);
    });

    // Take last 10 grades for the chart
    final chartGrades = sortedGrades.length > 10
        ? sortedGrades.sublist(sortedGrades.length - 10)
        : sortedGrades;

    if (chartGrades.isEmpty) {
      return const SizedBox.shrink();
    }

    // Convert grades to FlSpot points
    final spots = <FlSpot>[];
    for (int i = 0; i < chartGrades.length; i++) {
      final gradeValue = chartGrades[i].mark != null ? (chartGrades[i].mark as num).toDouble() : 0.0;
      spots.add(FlSpot(i.toDouble(), gradeValue));
    }

    // Calculate min and max for Y axis
    final minY = 1.0;
    final maxY = 6.0;

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
                          if (index >= 0 && index < chartGrades.length) {
                            final dateStr = chartGrades[index].date;
                            try {
                              final date = DateTime.parse(dateStr ?? '');
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
                          final gradeValue = spot.y;
                          Color dotColor;

                          if (apiStore.useGradeColors) {
                            dotColor = GradeUtils.getGradeColor(
                              gradeValue,
                              apiStore.gradeRedThreshold,
                              apiStore.gradeYellowThreshold,
                              true,
                            );
                          } else {
                            dotColor = Theme.of(context).colorScheme.primary;
                          }

                          return FlDotCirclePainter(
                            radius: 4,
                            color: dotColor,
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
                  minY: minY,
                  maxY: maxY,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Last ${chartGrades.length} grades over time',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
