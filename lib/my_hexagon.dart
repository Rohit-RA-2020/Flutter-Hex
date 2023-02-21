import 'dart:math' as math;

import 'package:flutter/material.dart';

class HexagonGridDemo extends StatelessWidget {
  const HexagonGridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hexagon Grid Demo'),
      ),
      body: Center(
        child: CustomPaint(
          painter: HexagonPainter(
            const Offset(0, 0),
          ),
        ),
      ),
    );
  }
}

// create a custom painter to draw a hexagon

class HexagonPainter extends CustomPainter {
  static const int sidesOfHexagon = 6;
  final double radius = 100;
  final Offset center;

  HexagonPainter(this.center);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    Path path = createHexagonPath();
    canvas.drawPath(path, paint);
  }

  Path createHexagonPath() {
    final path = Path();
    var angle = (math.pi * 2) / sidesOfHexagon;
    Offset firstPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));
    path.moveTo(firstPoint.dx + center.dx, firstPoint.dy + center.dy);
    for (int i = 1; i <= sidesOfHexagon; i++) {
      double x = radius * math.cos(angle * i) + center.dx;
      double y = radius * math.sin(angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
