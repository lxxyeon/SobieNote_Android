import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/common/const/text_style.dart';

class ReportGauge extends StatelessWidget {
  final double percentage;

  const ReportGauge({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('소비 목표를 이만큼 달성했어요', style: kTitleTextStyle)),
        const SizedBox(height: 60),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomPaint(
              size: const Size(200, 100), // 너비 200, 높이 100
              painter: _GaugePainter(percentage),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percentage;

  _GaugePainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height * 2);
    final startAngle = math.pi;
    final sweepAngle = math.pi * percentage;

    final basePaint =
        Paint()
          ..color = Colors.grey[300]!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 16
          ..strokeCap = StrokeCap.round;

    final valuePaint =
        Paint()
          ..shader = LinearGradient(
            colors: [PINK, DARK_PINK],
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 16
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, math.pi, false, basePaint);
    canvas.drawArc(rect, startAngle, sweepAngle, false, valuePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
