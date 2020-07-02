import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;

  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double progress = (0.0 + animation.value) * 2 * math.pi;

    Paint paint = Paint()
      ..color = progress == 0.0 ? color : backgroundColor
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1)
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2,
      paint,
    );

    Paint shadowPaint = Paint()
      ..color = Color.fromRGBO(0, 0, 0, 0.2)
      ..strokeWidth = 15.0
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 10);

    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2,
      paint,
    );

    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 1.875,
      shadowPaint,
    );

    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 2.15,
      shadowPaint,
    );

    paint.color = color;
    paint.maskFilter = null;

    canvas.drawArc(
      Offset.zero & size,
      math.pi * 1.5,
      -progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
