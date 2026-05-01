import 'package:flutter/material.dart';
import '../utils/grade_utils.dart';
import '../providers/api_store.dart';

class AnimatedGradeBadge extends StatefulWidget {
  final double gradeValue;
  final String displayText;
  final ApiStore apiStore;

  const AnimatedGradeBadge({
    super.key,
    required this.gradeValue,
    required this.displayText,
    required this.apiStore,
  });

  @override
  State<AnimatedGradeBadge> createState() => _AnimatedGradeBadgeState();
}

class _AnimatedGradeBadgeState extends State<AnimatedGradeBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Only animate if grade is 6.0
    if (widget.gradeValue == 6.0) {
      _rotationController.repeat();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedGradeBadge oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation if grade changes to/from 6.0
    if (widget.gradeValue == 6.0 && !_rotationController.isAnimating) {
      _rotationController.repeat();
    } else if (widget.gradeValue != 6.0 && _rotationController.isAnimating) {
      _rotationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gradeValue != 6.0) {
      // Regular badge without animation
      return _buildBadge(context);
    }

    // Animated badge with spinning border
    return RotationTransition(
      turns: _rotationController,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: _buildBadge(context),
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    final color = widget.apiStore.useGradeColors
        ? GradeUtils.getGradeColor(
            widget.gradeValue,
            widget.apiStore.gradeRedThreshold,
            widget.apiStore.gradeYellowThreshold,
            true,
          )
        : Theme.of(context).colorScheme.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: widget.apiStore.useGradeColors
            ? GradeUtils.getGradeColor(
                widget.gradeValue,
                widget.apiStore.gradeRedThreshold,
                widget.apiStore.gradeYellowThreshold,
                true,
              ).withValues(alpha: 0.15)
            : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: widget.apiStore.useGradeColors
            ? Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1,
              )
            : null,
      ),
      child: Text(
        widget.displayText,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
