import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final verticalLines = 10;
    final horizontalLines = 10;

    final double dx = size.width / verticalLines;
    final double dy = size.height / horizontalLines;

    for (double x = 0; x <= size.width; x += dx) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += dy) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}