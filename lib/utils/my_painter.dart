import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class MyPainter extends CustomPainter {

  final ui.Image image;
  final ColorFilter filter;
  final Size screenSize;
  MyPainter({this.image, this.filter, this.screenSize});

  @override
  void paint(Canvas canvas, Size size) {

    double width = size.width > screenSize.width ? size.width / 2 : size.width;
    double height = size.height > screenSize.height/2 ? size.height / 2 : size.height;

    print("Canvas width = $width");
    print("Canvas height = ${size.height}");

    bool isHeightLarger = height > width;
    double radius = isHeightLarger ? height*0.5 : width*0.5;
    Path path = Path()
      ..addOval(Rect.fromCircle(center: Offset(width, height), radius: radius));

    canvas.clipPath(path);
    canvas.drawImage(image, Offset(0.0,0.0), Paint()..colorFilter = filter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}


//void paint(Canvas canvas, Size size) {
//
//     double width = size.width > screenSize.width ? size.width / 2 : size.width;
//     double height = size.height > screenSize.height/2 ? size.height / 2 : size.height;
//     double halfWidth = width / 2;
//
//     print("Canvas width = $width");
//     print("Canvas height = ${size.height}");
//
//     // double bigRadius = halfWidth;
//     // double radius = halfWidth / 1.5;
//     // double degreesPerStep = _degToRad(360 / 5);
//     // double halfDegreesPerStep = degreesPerStep / 2;
//
//     //  var path = Path();
//     // double max = 2 * math.pi;
//     // path.moveTo(width, halfWidth);
//     //
//     // for (double step = 0; step < max; step += degreesPerStep) {
//     //   path.lineTo(halfWidth + bigRadius * math.cos(step),
//     //       halfWidth + bigRadius * math.sin(step));
//     //   path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
//     //       halfWidth + radius * math.sin(step + halfDegreesPerStep));
//     // }
//     // canvas.clipPath(path);
//     bool isHeightLarger = height > width;
//     double radius = isHeightLarger ? height*0.5 : width*0.5;
//     Path path = Path()
//       ..addOval(Rect.fromCircle(center: Offset(width, height), radius: radius));
//
//     canvas.clipPath(path);
//
//     //canvas.drawCircle(Offset(size.width/2,size.height/2), size.width/4, Paint()..colorFilter = filter);
//     canvas.drawImage(image, Offset(0.0,0.0), Paint()..colorFilter = filter);
//   }


//num _degToRad(num deg) => deg * (math.pi / 180.0);