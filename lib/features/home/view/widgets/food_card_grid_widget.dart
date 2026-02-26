import 'package:flutter/material.dart';

class FoodCardGridWidget extends StatelessWidget {
  const FoodCardGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Flex(
        mainAxisSize: MainAxisSize.min,
        direction: Axis.vertical,
        children: [
          Flexible(flex: 1, child: Image.asset('assets/burger.png')),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Big Burger 🍔',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  'this is a 250 GM Burger with extra cheese and tomato and extra cheese and tomato and extra cheese and tomato',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '350 L.E',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
