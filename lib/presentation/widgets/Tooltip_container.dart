import 'package:flutter/material.dart';

class TooltipContainer extends StatelessWidget {
  final String message;
  final double containerHeight;

  const TooltipContainer({
    super.key,
    required this.message,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TooltipLinePainter(containerHeight),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class TooltipLinePainter extends CustomPainter {
  final double containerHeight;

  TooltipLinePainter(this.containerHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(0, -80),
      Offset(0, containerHeight-85),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
