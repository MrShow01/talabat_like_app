import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaterFillingCircle extends StatefulWidget {
  const WaterFillingCircle({super.key});

  @override
  State<WaterFillingCircle> createState() => _WaterFillingCircleState();
}

class _WaterFillingCircleState extends State<WaterFillingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Moves the wave horizontally
    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_controller);

    // Fills the water from 0% to 70% (0.0 to 0.7)
    _fillAnimation = Tween<double>(
      begin: 0.0,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true); // Continuous waving
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(200, 200),
            painter: WaterPainter(
              waveValue: _waveAnimation.value,
              fillLevel: _fillAnimation.value,
            ),
          );
        },
      ),
    );
  }
}

class WaterPainter extends CustomPainter {
  final double waveValue;
  final double fillLevel;

  WaterPainter({required this.waveValue, required this.fillLevel});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    // 1. Draw the Background Circle (The Container)
    final circlePaint = Paint()
      ..color = Colors.blue.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circlePaint);

    // 2. Clip the Canvas to a Circle (So water doesn't spill out)
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
    );

    // 3. Draw the Water Wave
    final waterPaint = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final path = Path();
    final double viewHeight = size.height;
    final double viewWidth = size.width;

    // Calculate the baseline Y based on fill level (0.0 is empty, 1.0 is full)
    final double waterHeight = viewHeight * (1 - fillLevel);

    path.moveTo(0, waterHeight);

    // Generate the Sine Wave
    for (double x = 0; x <= viewWidth; x++) {
      // Sine wave formula: y = Amplitude * sin(Frequency * x + Phase) + Offset
      double y =
          8 * math.sin((x / viewWidth * 2 * math.pi) + waveValue) + waterHeight;
      path.lineTo(x, y);
    }

    // Complete the path to fill the bottom
    path.lineTo(viewWidth, viewHeight);
    path.lineTo(0, viewHeight);
    path.close();

    canvas.drawPath(path, waterPaint);
  }

  @override
  bool shouldRepaint(covariant WaterPainter oldDelegate) => true;
}
