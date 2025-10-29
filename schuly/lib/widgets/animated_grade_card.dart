import 'package:flutter/material.dart';

class AnimatedGradeCard extends StatefulWidget {
  final double? gradeValue;
  final Widget child;
  final bool enableFlashyAnimations;

  const AnimatedGradeCard({
    super.key,
    required this.gradeValue,
    required this.child,
    this.enableFlashyAnimations = true,
  });

  @override
  State<AnimatedGradeCard> createState() => _AnimatedGradeCardState();
}

class _AnimatedGradeCardState extends State<AnimatedGradeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Only animate if grade is 6.0
    if (widget.gradeValue == 6.0) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedGradeCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation if grade changes to/from 6.0 or animations are toggled
    final shouldAnimate = widget.gradeValue == 6.0 && widget.enableFlashyAnimations;
    final shouldHaveBeenAnimating = oldWidget.gradeValue == 6.0 && oldWidget.enableFlashyAnimations;

    if (shouldAnimate && !_animationController.isAnimating && _animationController.value == 0) {
      _animationController.forward();
    } else if (shouldAnimate && !shouldHaveBeenAnimating) {
      // Grade changed to 6.0 or animations enabled, reset and replay animation
      _animationController.reset();
      _animationController.forward();
    } else if (!shouldAnimate && _animationController.isAnimating) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only apply animation if grade is 6.0 and flashy animations are enabled
    if (widget.gradeValue != 6.0 || !widget.enableFlashyAnimations) {
      return widget.child;
    }

    // Animated RGB shadow for perfect grades
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // Create rotating RGB colors for the shadow
        final hue = (_animationController.value * 360) % 360;
        final shadowColor = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();

        // Calculate opacity: full for 4.5 seconds, then fade out in 0.5 seconds
        final fadeStartProgress = 4.5 / 5.0; // Start fading at 4.5 seconds
        double opacity;
        if (_animationController.value < fadeStartProgress) {
          opacity = 1.0;
        } else {
          // Lerp from 1.0 to 0.0 during the fade phase
          opacity = 1.0 - ((_animationController.value - fadeStartProgress) / (1.0 - fadeStartProgress));
        }

        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: shadowColor.withValues(alpha: 0.6 * opacity),
                blurRadius: 12,
                spreadRadius: 2,
              ),
              // Add a second layer for more intensity
              BoxShadow(
                color: HSVColor.fromAHSV(1.0, (hue + 120) % 360, 1.0, 1.0)
                    .toColor()
                    .withValues(alpha: 0.3 * opacity),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
