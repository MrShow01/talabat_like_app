import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with SingleTickerProviderStateMixin {
  // double width = 100;
  // double height = 100;
  // double radius = 0;
  // double opacity = 1;
  // Color color = Colors.orange;
  // Alignment alignment = Alignment.bottomCenter;
  // Alignment alignment2 = Alignment.bottomCenter;
  // CrossFadeState crossFadeState = CrossFadeState.showFirst;

  AnimationController? _controller;

  Animation? _heightAnimation;
  Animation? _widthAnimation;
  Animation? _colorAnimation;
  Animation? _textAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 50.0,
      end: 200.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.bounceOut));
    _widthAnimation = Tween<double>(
      begin: 200.0,
      end: 50.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.bounceOut));
    _colorAnimation = ColorTween(
      begin: Colors.orange,
      end: Colors.blue,
    ).animate(_controller!);
    _textAnimation = TextStyleTween(
      begin: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.orange,
      ),
      end: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w900,
        color: Colors.blue,
      ),
    ).animate(_controller!);
    _controller!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   // width = width == 100 ? 200 : 100;
          //   // height = height == 100 ? 200 : 100;
          //   // radius = radius == 0 ? 16 : 0;
          //   opacity = opacity == 1 ? 0.0 : 1;
          //   // color = color == Colors.orange ? Colors.blue : Colors.orange;
          //   alignment = alignment == Alignment.bottomCenter
          //       ? Alignment.topCenter
          //       : Alignment.bottomCenter;
          //   alignment2 = alignment2 == Alignment.bottomCenter
          //       ? Alignment.topCenter
          //       : Alignment.bottomCenter;
          //   crossFadeState = crossFadeState == CrossFadeState.showFirst
          //       ? CrossFadeState.showSecond
          //       : CrossFadeState.showFirst;
          // });
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.refresh, color: Colors.white),
      ),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([_controller]),
                builder: (context, child) {
                  return Column(
                    children: [
                      // Container(
                      //   width: _widthAnimation?.value,
                      //   height: _heightAnimation?.value,
                      //   decoration: BoxDecoration(
                      //     color: _colorAnimation?.value,
                      //     borderRadius: BorderRadius.circular(16),
                      //   ),
                      // ),
                      // Text('Animated Text', style: _textAnimation?.value),
                      RotationTransition(
                        turns: Tween<double>(
                          begin: -0.02,
                          end: 0.02,
                        ).animate(_controller!),
                        child: Icon(
                          Icons.notifications,
                          size: 150,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                },
                // AnimatedContainer(
                //   duration: Duration(milliseconds: 1500),
                //   width: width,
                //   height: height,
                //   decoration: BoxDecoration(
                //     color: color.withValues(alpha: opacity),
                //     borderRadius: BorderRadius.circular(radius),
                //   ),
                // ),
                // Expanded(
                //   child: Stack(
                //     children: [
                //       AnimatedOpacity(
                //         opacity: opacity,
                //         duration: Duration(milliseconds: 500),
                //         child: Container(
                //           height: 150,
                //           width: 150,
                //           color: Colors.orange,
                //         ),
                //       ),
                //       Center(
                //         child: AnimatedCrossFade(
                //           firstChild: Image.asset(
                //             'assets/burger.png',
                //             width: 200,
                //             height: 200,
                //             fit: BoxFit.fill,
                //           ),
                //           secondChild: Image.asset(
                //             'assets/meat.png',
                //             width: 200,
                //             height: 200,
                //             fit: BoxFit.fill,
                //           ),
                //           crossFadeState: crossFadeState,
                //           duration: Duration(milliseconds: 1500),
                //         ),
                //       ),
                //       AnimatedAlign(
                //         alignment: alignment2,
                //         curve: Curves.easeOut,
                //         duration: Duration(milliseconds: 3500),
                //         child: Container(
                //           width: width,
                //           height: height,
                //           decoration: BoxDecoration(
                //             color: Colors.red.withValues(alpha: opacity),
                //             borderRadius: BorderRadius.circular(radius),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // AnimatedPadding(
                //   duration: Duration(milliseconds: 1500),
                //   padding: const EdgeInsets.all(0.0),
                //   child: Container(
                //     width: width,
                //     height: height,
                //     decoration: BoxDecoration(
                //       color: color.withValues(alpha: opacity),
                //       borderRadius: BorderRadius.circular(radius),
                //     ),
                //   ),
                // ),
                // Container(
                //   width: width,
                //   height: height,
                //   decoration: BoxDecoration(
                //     color: color.withValues(alpha: opacity),
                //     borderRadius: BorderRadius.circular(radius),
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
