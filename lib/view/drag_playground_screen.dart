import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DragPlaygroundScreen extends StatefulWidget {
  final int begin;
  final int end;
  final Duration duration;

  const DragPlaygroundScreen({
    super.key,
    required this.begin,
    required this.end,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<DragPlaygroundScreen> createState() => _DragPlaygroundScreenState();
}

class _DragPlaygroundScreenState extends State<DragPlaygroundScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _countAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    // 1. Define the IntTween for whole numbers
    _countAnimation = IntTween(begin: widget.begin, end: widget.end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear, // Makes the counting slow down at the end
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _countAnimation,
      builder: (context, child) {
        return Center(
          child: Text(
            _countAnimation.value.toString(),
            style: TextStyle(
              fontSize: 60.sp, // Using your ScreenUtil
              fontWeight: FontWeight.bold,
              fontFeatures: const [
                FontFeature.tabularFigures(),
              ], // Keeps numbers from jumping
            ),
          ),
        );
      },
    );
  }
}
