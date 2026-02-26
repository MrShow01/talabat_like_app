import 'package:flutter/material.dart';

class Page3Screen extends StatelessWidget {
  static const String routeName = 'page_3_screen';

  const Page3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 3')),
      body: Center(child: Text('Page 3')),
    );
  }
}
