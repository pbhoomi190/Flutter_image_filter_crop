import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    double width = size.width;
    print(width);
    double halfWidth = width / 2;

    double bigRadius = halfWidth;
    double radius = halfWidth / 1.5;
    double degreesPerStep = _degToRad(360 / 5);
    double halfDegreesPerStep = degreesPerStep / 2;

    var path = Path();
    double max = 2 * math.pi;
    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + bigRadius * math.cos(step),
          halfWidth + bigRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }

  num _degToRad(num deg) => deg * (math.pi / 180.0);

}