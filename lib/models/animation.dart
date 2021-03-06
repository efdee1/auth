import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:system_login/models/colors.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_swipe/liquid_swipe.dart';



class BackgroundPainter extends CustomPainter {
  BackgroundPainter({
    Animation<double> animation,
  }): deepBrownPaint = Paint()..color = Sunlight.deepBrown..style= PaintingStyle.fill,
        redPaint = Paint()..color = Sunlight.red..style= PaintingStyle.fill,
        orangePaint = Paint()..color = Sunlight.orange..style= PaintingStyle.fill,
        lightYellowPaint = Paint()..color = Sunlight.lightYellow..style= PaintingStyle.fill,
        amberPaint = Paint()..color = Sunlight.amber..style= PaintingStyle.fill,
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        orangeAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        redAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        deepBrownAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        amberAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),

  super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> deepBrownAnim;
  final Animation<double> redAnim;
  final Animation<double> orangeAnim;
 // final Animation<double> lightYellowAnim;
  final Animation<double> amberAnim;


  final Paint deepBrownPaint;
  final Paint redPaint;
  final Paint orangePaint;
  final Paint lightYellowPaint;
  final Paint amberPaint;

  @override
  void paint(Canvas canvas, Size size) {
    print('painting');
    paintDeepBrown(canvas, size);
    paintRed(canvas,size);
    paintOrange(canvas, size);


  }

  void paintDeepBrown(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height/2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
        0,
        lerpDouble(0, size.height, deepBrownAnim.value)
    );
    _addPointsToPath(path,  [
      Point(
        lerpDouble(0, size.width / 3, deepBrownAnim.value),
        lerpDouble(0, size.height, deepBrownAnim.value),

      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value),
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value),

      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),

      ),
    ]);
    canvas.drawPath(path, deepBrownPaint);
  }


  void paintRed(Canvas canvas,Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(
        size.height / 4,
        size.height / 2,
        redAnim.value,
      ),
    );
    _addPointsToPath(
      path,
      [
        Point(
          size.width / 4,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 4, size.height / 2, liquidAnim.value),
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, redAnim.value),
        ),
        Point(
          size.width,
          lerpDouble(size.height / 5, size.height / 4, redAnim.value),
        ),
      ],
    );

    canvas.drawPath(path, redPaint);
  }

  void paintOrange(Canvas canvas,Size size) {
    if (orangeAnim.value > 0) {
      final path = Path();

      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(0, size.height / 12, orangeAnim.value),
      );

      _addPointsToPath(path, [
        Point(
          size.width / 7,
          lerpDouble(0, size.height / 6, liquidAnim.value),
        ),
        Point(
          size.width / 3,
          lerpDouble(0, size.height / 10, liquidAnim.value),
        ),
        Point(
          size.width / 3 * 2,
          lerpDouble(0, size.height / 8, liquidAnim.value),
        ),
        Point(
          size.width * 3 / 4,
          0,
        ),
      ]);

      canvas.drawPath(path, orangePaint);
    }
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }



  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // connect the last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point{
  final double x;
  final double y;

  Point(this.x,this.y);
}
/// Custom curve to give gooey spring effect
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}