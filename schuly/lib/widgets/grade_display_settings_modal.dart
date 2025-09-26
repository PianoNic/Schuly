import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/api_store.dart';
import '../services/storage_service.dart';
import '../utils/grade_utils.dart';
import '../l10n/app_localizations.dart';

class GradeDisplaySettingsModal extends StatefulWidget {
  const GradeDisplaySettingsModal({super.key});

  @override
  State<GradeDisplaySettingsModal> createState() => _GradeDisplaySettingsModalState();
}

class _GradeDisplaySettingsModalState extends State<GradeDisplaySettingsModal> {
  GradeDisplayMode _selectedMode = GradeDisplayMode.exact;
  bool _useGradeColors = true;
  double _redThreshold = 4.0;
  double _yellowThreshold = 5.0;

  @override
  void initState() {
    super.initState();
    _loadCurrentSettings();
  }

  Future<void> _loadCurrentSettings() async {
    final modeString = await StorageService.getGradeDisplayMode();
    final useColors = await StorageService.getUseGradeColors();
    final redThreshold = await StorageService.getGradeRedThreshold();
    final yellowThreshold = await StorageService.getGradeYellowThreshold();

    setState(() {
      switch (modeString) {
        case 'rounded':
          _selectedMode = GradeDisplayMode.rounded;
          break;
        case 'both':
          _selectedMode = GradeDisplayMode.both;
          break;
        default:
          _selectedMode = GradeDisplayMode.exact;
      }
      _useGradeColors = useColors;
      _redThreshold = redThreshold;
      _yellowThreshold = yellowThreshold;
    });
  }

  Future<void> _saveSetting(GradeDisplayMode mode) async {
    String modeString;
    switch (mode) {
      case GradeDisplayMode.rounded:
        modeString = 'rounded';
        break;
      case GradeDisplayMode.both:
        modeString = 'both';
        break;
      default:
        modeString = 'exact';
    }

    await StorageService.setGradeDisplayMode(modeString);

    // Update the API store to trigger a rebuild
    if (mounted) {
      final apiStore = Provider.of<ApiStore>(context, listen: false);
      apiStore.setGradeDisplayMode(mode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Example grade for demonstration
    const exampleGrade = 4.73;

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85, // Increased to 85% since SafeArea handles the boundaries
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Modal handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title
            Row(
              children: [
                Icon(
                  Icons.grade_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.gradeDisplaySettings ?? 'Grade Display Settings',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              localizations.chooseGradeDisplay ?? 'Choose how grades are displayed:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Exact grades option
            _buildOption(
              context,
              title: localizations.exactGrades ?? 'Exact Grades',
              subtitle: localizations.exactGradesDesc ?? 'Show precise grade values',
              example: GradeUtils.formatGrade(exampleGrade),
              icon: Icons.calculate_outlined,
              value: GradeDisplayMode.exact,
              groupValue: _selectedMode,
              onChanged: (value) {
                setState(() {
                  _selectedMode = value!;
                });
                _saveSetting(value!);
                Navigator.of(context).pop();
              },
            ),

            const SizedBox(height: 12),

            // Rounded grades option (Zeugnisnote)
            _buildOption(
              context,
              title: localizations.roundedGrades ?? 'Report Card Grades',
              subtitle: localizations.roundedGradesDesc ?? 'Rounded to nearest 0.5 (Zeugnisnote)',
              example: GradeUtils.formatSwissGrade(exampleGrade),
              icon: Icons.school_outlined,
              value: GradeDisplayMode.rounded,
              groupValue: _selectedMode,
              onChanged: (value) {
                setState(() {
                  _selectedMode = value!;
                });
                _saveSetting(value!);
                Navigator.of(context).pop();
              },
              exampleColor: Colors.green,
            ),

            const SizedBox(height: 12),

            // Both option
            _buildOption(
              context,
              title: localizations.bothGrades ?? 'Both',
              subtitle: localizations.bothGradesDesc ?? 'Show exact and rounded grades',
              example: GradeUtils.getDisplayGrade(exampleGrade, GradeDisplayMode.both),
              icon: Icons.view_column_outlined,
              value: GradeDisplayMode.both,
              groupValue: _selectedMode,
              onChanged: (value) {
                setState(() {
                  _selectedMode = value!;
                });
                _saveSetting(value!);
                Navigator.of(context).pop();
              },
            ),

            const SizedBox(height: 24),

            // Grade Colors Section
            Divider(color: theme.dividerColor),
            const SizedBox(height: 16),

            Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.gradeColors ?? 'Grade Colors',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Toggle for using colors
            SwitchListTile(
              title: Text(localizations.useGradeColors ?? 'Use Grade Colors'),
              subtitle: Text(localizations.useGradeColorsDesc ?? 'Color grades based on their value'),
              value: _useGradeColors,
              onChanged: (value) async {
                setState(() {
                  _useGradeColors = value;
                });
                await StorageService.setUseGradeColors(value);
                if (mounted) {
                  final apiStore = Provider.of<ApiStore>(context, listen: false);
                  apiStore.setUseGradeColors(value);
                }
              },
            ),

            if (_useGradeColors) ...[
              const SizedBox(height: 16),

              // Red threshold
              _buildThresholdSlider(
                context,
                label: localizations.redThreshold ?? 'Red (below)',
                value: _redThreshold,
                min: 1.0,
                max: 6.0,
                color: Colors.red,
                onChanged: (value) async {
                  setState(() {
                    _redThreshold = value;
                    // Ensure yellow threshold is higher
                    if (_yellowThreshold <= _redThreshold) {
                      _yellowThreshold = _redThreshold + 0.5;
                    }
                  });
                  await StorageService.setGradeRedThreshold(_redThreshold);
                  await StorageService.setGradeYellowThreshold(_yellowThreshold);
                  if (mounted) {
                    final apiStore = Provider.of<ApiStore>(context, listen: false);
                    apiStore.setGradeColorThresholds(_redThreshold, _yellowThreshold);
                  }
                },
              ),

              // Yellow threshold
              _buildThresholdSlider(
                context,
                label: localizations.yellowThreshold ?? 'Yellow (below)',
                value: _yellowThreshold,
                min: 1.0,
                max: 6.0,
                color: Colors.orange,
                onChanged: (value) async {
                  setState(() {
                    _yellowThreshold = value;
                    // Ensure red threshold is lower
                    if (_redThreshold >= _yellowThreshold) {
                      _redThreshold = _yellowThreshold - 0.5;
                    }
                  });
                  await StorageService.setGradeRedThreshold(_redThreshold);
                  await StorageService.setGradeYellowThreshold(_yellowThreshold);
                  if (mounted) {
                    final apiStore = Provider.of<ApiStore>(context, listen: false);
                    apiStore.setGradeColorThresholds(_redThreshold, _yellowThreshold);
                  }
                },
              ),

              // Green info
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${localizations.greenThreshold ?? 'Green'}: ≥ ${_yellowThreshold.toStringAsFixed(1)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Info card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      localizations.gradeRoundingInfo ?? 'Report card grades are rounded to the nearest 0.5 as they appear on official documents.',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getGradeColor(double grade) {
    if (grade < _redThreshold) return Colors.red;
    if (grade < _yellowThreshold) return Colors.orange;
    return Colors.green;
  }

  Widget _buildThresholdSlider(
    BuildContext context, {
    required String label,
    required double value,
    required double min,
    required double max,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(label, style: theme.textTheme.bodyMedium),
                ],
              ),
              Text(
                value.toStringAsFixed(1),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            inactiveTrackColor: color.withValues(alpha: 0.2),
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) * 2).round(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String example,
    required IconData icon,
    required GradeDisplayMode value,
    required GradeDisplayMode groupValue,
    required ValueChanged<GradeDisplayMode?> onChanged,
    Color? exampleColor,
  }) {
    final theme = Theme.of(context);
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : null,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (exampleColor ?? theme.colorScheme.primary).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Example: $example',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: exampleColor ?? theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}