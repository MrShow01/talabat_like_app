import 'package:flutter/material.dart';
import 'package:talabat_like_app/widgets/food_card_grid_widget.dart';
import 'package:talabat_like_app/widgets/food_card_widget.dart';
import 'package:talabat_like_app/widgets/my_location_widget.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});
  @override
  Widget build(BuildContext context) {
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
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                  ),
                  itemBuilder: (context, index) => FoodCardWidget(),
                ),

                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) => FoodCardGridWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
