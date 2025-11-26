import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/grade_tile.dart';
import '../widgets/grade_statistics_view.dart';
import '../widgets/subject_analytics_view.dart';
import '../providers/api_store.dart';
import '../utils/grade_utils.dart';
import 'package:schuly/api/lib/api.dart';
import '../l10n/app_localizations.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<ApiStore>(
      builder: (context, apiStore, _) {
        final grades = apiStore.grades;
        if (grades == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Filter out grades with mark 0 (not available yet)
        // Keep grades where mark is null or non-zero
        final availableGrades = grades.where((grade) {
          if (grade.mark == null) {
            return true; // Keep grades with null mark
          }
          final markValue = (grade.mark as num).toDouble();
          return markValue != 0; // Filter out only if explicitly 0
        }).toList();

        if (availableGrades.isEmpty) {
          return Center(child: Text(localizations.noGradesFound));
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 0,
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: localizations.overview),
                  Tab(text: localizations.statistics),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // Overview Tab
              _buildOverviewTab(context, availableGrades, apiStore, localizations),
              // Statistics Tab
              GradeStatisticsView(grades: availableGrades),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverviewTab(BuildContext context, List<GradeDto> grades, ApiStore apiStore, AppLocalizations localizations) {
    // Group grades by subject
    final Map<String, List<GradeDto>> gradesBySubject = {};
    for (final grade in grades) {
      gradesBySubject.putIfAbsent(grade.subject ?? '', () => []).add(grade);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await apiStore.fetchGrades(forceRefresh: true);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Subject Cards
            ...gradesBySubject.entries.map((entry) {
              final subjectAverage = GradeUtils.calculateWeightedAverage(entry.value);

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SubjectAnalyticsView(
                        subjectName: entry.key,
                        subjectGrades: entry.value,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subject header with average in top right corner
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 12, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                entry.key,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: subjectAverage != null && apiStore.useGradeColors
                                  ? GradeUtils.getGradeColor(subjectAverage, apiStore.gradeRedThreshold, apiStore.gradeYellowThreshold, true).withValues(alpha: 0.15)
                                  : Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(16),
                                border: subjectAverage != null && apiStore.useGradeColors
                                  ? Border.all(
                                      color: GradeUtils.getGradeColor(subjectAverage, apiStore.gradeRedThreshold, apiStore.gradeYellowThreshold, true).withValues(alpha: 0.3),
                                      width: 1,
                                    )
                                  : null,
                              ),
                              child: Text(
                                subjectAverage != null
                                    ? GradeUtils.getDisplayGrade(subjectAverage, apiStore.gradeDisplayMode)
                                    : '?',
                                style: TextStyle(
                                  color: subjectAverage != null && apiStore.useGradeColors
                                    ? GradeUtils.getGradeColor(subjectAverage, apiStore.gradeRedThreshold, apiStore.gradeYellowThreshold, true)
                                    : Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Grade tiles
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        child: Column(
                          children: entry.value.map((gradeData) => GradeTile(
                                grade: gradeData,
                              )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}