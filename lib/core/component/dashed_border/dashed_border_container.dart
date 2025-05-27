import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color? dashedBorderColor;
  final double borderRadius;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.dashedBorderColor,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        dashedBorderColor: dashedBorderColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}


class DashedBorderPainter extends CustomPainter {
  final Color? dashedBorderColor;
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;
  final double borderRadius;

  DashedBorderPainter({
    this.dashedBorderColor = AppColors.primaryColor,
    this.strokeWidth = 1.0,
    this.dashWidth = 12.0,
    this.gapWidth = 5.0,
    this.borderRadius = 12.0, // default rounded corner
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = dashedBorderColor!
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final PathMetrics pathMetrics = path.computeMetrics();
    for (final PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < pathMetric.length) {
        final double nextSegment = draw ? dashWidth : gapWidth;
        final double segmentLength = (distance + nextSegment < pathMetric.length)
            ? nextSegment
            : pathMetric.length - distance;

        if (draw) {
          final Path extractPath =
          pathMetric.extractPath(distance, distance + segmentLength);
          canvas.drawPath(extractPath, paint);
        }

        distance += nextSegment;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
