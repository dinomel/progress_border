library progress_border;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProgressBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final List<Color> colors;
  final BorderRadiusGeometry? borderRadius;

  const ProgressBorder({
    Key? key,
    required this.child,
    required this.colors,
    this.padding = const EdgeInsets.all(2),
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RotatingProgressIndicator(
          borderRadius: borderRadius,
          colors: colors,
        ),
        Padding(
          padding: padding,
          child: child,
        ),
      ],
    );
  }
}

class RotatingProgressIndicator extends StatefulWidget {
  final Duration loopDuration;
  final BorderRadiusGeometry? borderRadius;
  final List<Color> colors;

  const RotatingProgressIndicator({
    Key? key,
    this.loopDuration = const Duration(milliseconds: 5000),
    this.borderRadius,
    required this.colors,
  }) : super(key: key);

  @override
  State<RotatingProgressIndicator> createState() =>
      _RotatingProgressIndicatorState();
}

class _RotatingProgressIndicatorState extends State<RotatingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.loopDuration,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: SweepGradient(
              startAngle: _controller.value * 2 * math.pi,
              endAngle: math.pi * 2 + _controller.value * 2 * math.pi,
              tileMode: TileMode.repeated,
              colors: widget.colors,
            ),
          ),
        );
      },
    );
  }
}
