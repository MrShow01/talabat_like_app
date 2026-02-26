import 'dart:developer' show log;
import 'dart:math' as math hide log;

import 'package:flutter/material.dart';
import 'package:talabat_like_app/features/home/view/widgets/food_card_grid_widget.dart';
import 'package:talabat_like_app/features/home/view/widgets/food_card_widget.dart';
import 'package:talabat_like_app/shared_widgets/my_location_widget.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});
  @override
  Widget build(BuildContext context) {
    log(math.pi.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                MyLocationWidget(),
                Text(
                  'Burger 🍔',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                ListTile(
                  leading: Image.asset('assets/burger.png'),
                  title: Text(
                    'Big Burger 🍔',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  subtitle: Text(
                    'this is a 250 GM Burger with extra cheese and tomato and extra cheese and tomato and extra cheese and tomato',
                  ),
                  trailing: Text(
                    '15\$',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  dense: true,
                  enabled: false,
                ),
                ListTile(
                  leading: Image.asset('assets/burger.png'),
                  title: Text(
                    'Big Burger 🍔',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  subtitle: Text(
                    'this is a 250 GM Burger with extra cheese and tomato and extra cheese and tomato and extra cheese and tomato',
                  ),
                  trailing: Text(
                    '15\$',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  dense: false,
                  selected: true,
                  selectedColor: Colors.orange,
                  onTap: () {
                    print('Tapped');
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/burger.png'),
                  title: Text(
                    'Big Burger 🍔',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  subtitle: Text(
                    'this is a 250 GM Burger with extra cheese and tomato and extra cheese and tomato and extra cheese and tomato',
                  ),
                  trailing: Text(
                    '15\$',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  dense: false,
                  selected: false,
                  style: ListTileStyle.list,
                  onTap: () {
                    print('Tapped');
                  },
                ),

                // ListView.separated(
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: 3,
                //   separatorBuilder: (context, index) =>
                //       const SizedBox(height: 16),
                //   itemBuilder: (context, index) => ListTile(
                //     leading: Image.asset('assets/burger.png'),
                //     title: Text(
                //       'Big Burger 🍔',
                //       style: TextStyle(
                //         fontWeight: FontWeight.w700,
                //         fontSize: 20,
                //       ),
                //     ),
                //     subtitle: Text(
                //       'this is a 250 GM Burger with extra cheese and tomato and extra cheese and tomato and extra cheese and tomato',
                //     ),
                //     trailing: Text(
                //       '15\$',
                //       style: TextStyle(
                //         fontWeight: FontWeight.w700,
                //         fontSize: 20,
                //       ),
                //     ),
                //     dense: false,
                //     enabled: true,
                //     //    contentPadding: EdgeInsets.all(16),
                //     focusColor: Colors.red,
                //     horizontalTitleGap: 16,
                //     isThreeLine: false,
                //     selected: false,
                //     visualDensity: VisualDensity(
                //       vertical: VisualDensity.minimumDensity,
                //       horizontal: VisualDensity.minimumDensity,
                //     ),
                //   ),
                // ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) => FoodCardWidget(),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 3,
                  itemBuilder: (context, index) => FoodCardGridWidget(),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [FoodCardGridWidget(), FoodCardGridWidget()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
