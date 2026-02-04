import 'package:flutter/material.dart';

class FoodCardGridWidget extends StatelessWidget {
  const FoodCardGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Flex(
        mainAxisSize: MainAxisSize.min,
        direction: Axis.vertical,
        children: [
          Flexible(flex: 2, child: Image.asset('assets/burger.png')),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Big Burger 🍔',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: Text(
                    'this is a 250 GM Burger with extra cheese and tomato and extra cheese and tomato and extra cheese and tomato',
                    maxLines: 3,
                  ),
                ),
                Expanded(
                  child: Row(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
