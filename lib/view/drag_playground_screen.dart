import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DragPlaygroundScreen extends StatefulWidget {
  const DragPlaygroundScreen({super.key});

  @override
  State<DragPlaygroundScreen> createState() => _DragPlaygroundScreenState();
}

class _DragPlaygroundScreenState extends State<DragPlaygroundScreen> {
  List<double> scales = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
  List<Color> borderColors = [
    Colors.orange,
    Colors.orange,
    Colors.orange,
    Colors.orange,
    Colors.orange,
    Colors.orange,
  ];
  int acceptedData = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drag Playground')),
      body: Center(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => log('tapped ink well'),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Click me',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => log('Tapped gesture detector'),
                  onVerticalDragStart: (details) =>
                      log('Vertical drag start: ${details.globalPosition}'),
                  onVerticalDragCancel: () => log('Vertical drag cancel'),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Click me',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                CircularProgressIndicator(value: 0.3),
                CircularProgressIndicator(),
                LinearProgressIndicator(),
                LinearProgressIndicator(value: 0.5),

                Draggable<int>(
                  // Data is the value this Draggable stores.
                  data: 10,
                  feedback: Container(
                    color: Colors.deepOrange,
                    height: 100,
                    width: 100,
                    child: const Icon(Icons.directions_run),
                  ),
                  childWhenDragging: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.pinkAccent,
                    child: const Center(child: Text('Child When Dragging')),
                  ),
                  child: Transform(
                    transform: Matrix4.rotationY(9.5),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.lightGreenAccent,
                      child: const Center(child: Text('Draggable')),
                    ),
                  ),
                ),
                DragTarget<int>(
                  builder:
                      (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
                          height: 100.0,
                          width: 100.0,
                          color: Colors.cyan,
                          child: Center(
                            child: Text('Value is updated to: $acceptedData'),
                          ),
                        );
                      },
                  onAcceptWithDetails: (DragTargetDetails<int> details) {
                    setState(() {
                      acceptedData += details.data;
                    });
                  },
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPressStart: (_) =>
                        setState(() => scales[index] = 2.5),
                    onLongPressEnd: (_) => setState(() => scales[index] = 1.0),

                    onTap: () => setState(() {
                      if (borderColors[index] == Colors.orange) {
                        borderColors[index] = Colors.purple;
                        return;
                      } else {
                        borderColors[index] = Colors.orange;
                        return;
                      }
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColors[index],
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Transform.scale(
                        scale: scales[index],
                        child: Image.asset(
                          'assets/burger.png',
                          width: 100.w,
                          height: 100.h,
                        ),
                      ),
                    ),
                  ),
                ),
                // // ColoredBox(
                // //   color: Colors.black,
                // //   child: Transform(
                // //     alignment: Alignment.topLeft,
                // //     transform: Matrix4.skewY(0.3)..rotateZ(-math.pi / 12.0),
                // //     child: Container(
                // //       padding: const EdgeInsets.all(8.0),
                // //       color: const Color(0xFFE8581C),
                // //       child: const Text('Apartment for rent!'),
                // //     ),
                // //   ),
                // // ),
                // // Draggable(
                // //   feedback: Container(
                // //     color: Colors.red.withValues(alpha: 0.5),
                // //     padding: const EdgeInsets.all(15),
                // //     child: Icon(Icons.arrow_back, color: Colors.white),
                // //   ),
                // //   child: Container(
                // //     color: Colors.red,
                // //     padding: const EdgeInsets.all(15),
                // //     child: Icon(Icons.arrow_back, color: Colors.white),
                // //   ),
                // // ),
                // // DragTarget(
                // //   builder: (context, candidateData, rejectedData) {
                // //     return Container(
                // //       color: Colors.green,
                // //       padding: const EdgeInsets.all(15),
                // //       child: Icon(Icons.arrow_downward, color: Colors.white),
                // //     );
                // //   },
                // //   onAcceptWithDetails: (DragTargetDetails<int> details) {
                // //     log(
                // //       'Drag accepted with data: ${details.data}, at position: ${details.offset}',
                // //     );
                // //   },
                // // ),
                // // GestureDetector(
                // //   dragStartBehavior: DragStartBehavior.down,
                // //   onVerticalDragStart: (details) =>
                // //       log('Veertical drag start: ${details.globalPosition}'),
                // //   child: Container(
                // //     color: Colors.blue,
                // //     padding: const EdgeInsets.all(15),
                // //     child: Icon(Icons.arrow_forward, color: Colors.white),
                // //   ),
                // // ),

                // // //  SizedBox(height: 20),
                // // InkWell(
                // //   onTap: () => debugPrint('tapped ink well'),
                // //   child: Padding(
                // //     padding: const EdgeInsets.all(15),
                // //     child: Icon(Icons.arrow_back),
                // //   ),
                // // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
