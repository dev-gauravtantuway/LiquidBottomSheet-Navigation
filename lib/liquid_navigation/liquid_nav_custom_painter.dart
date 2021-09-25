import 'package:flutter/cupertino.dart';

class MyCustomPainter extends CustomPainter {
  final double value;
  final bool ifSheetPassedHalf;
  final Color color;

  MyCustomPainter(
    this.value,
    this.ifSheetPassedHalf,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(
        size.width * .0,
        size.height,
      )
      ..arcToPoint(
        Offset(
          size.width * .08,
          size.height * .64,
        ),
        radius: Radius.circular(size.height * .25),
      )
      ..lineTo(
        size.width * .23,
        size.height * .64,
      )
      ..cubicTo(
        size.width * .35,
        size.height * .61 + (3 * value),
        size.width * .39,
        size.height * .49 + (18 * value),
        size.width * .4,
        size.height * .30 + (41 * value),
      )
      ..arcToPoint(
        Offset(
          size.width * .6,
          size.height * .30 + (41 * value),
        ),
        radius: Radius.elliptical(
          10,
          (10 - (10 * value)),
        ),
        clockwise: ifSheetPassedHalf ? false : true,
      )
      ..cubicTo(
        size.width * .61,
        size.height * .49 + (18 * value),
        size.width * .65,
        size.height * .62 + (2 * value),
        size.width * .77,
        size.height * .63 + (2 * value),
      )
      ..lineTo(
        size.width * .92,
        size.height * .64,
      )
      ..arcToPoint(
        Offset(
          size.width,
          size.height,
        ),
        radius: Radius.circular(size.height * .25),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
