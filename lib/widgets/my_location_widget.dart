import 'package:flutter/material.dart';

class MyLocationWidget extends StatelessWidget {
  const MyLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Color(0xff111c3033),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/person.png',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Current location',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),

                Image.asset('assets/location.png'),
              ],
            ),
            Text(
              '19 Golf Street Naser City, Cairo Egypt',
              style: TextStyle(fontSize: 15, color: Color(0xff515151)),
            ),
          ],
        ),
        Image.asset('assets/notification.png', height: 40, width: 40),
      ],
    );
  }
}
