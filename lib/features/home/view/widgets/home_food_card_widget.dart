import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/edit_product/view/edit_product_screen.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_controller.dart';
import 'package:talabat_like_app/features/home/model/product_model.dart';

class HomeFoodCardWidget extends StatelessWidget {
  final Products product;
  const HomeFoodCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => EditProductScreen(product: product),
            ),
          )
          .whenComplete(
            () => context.read<HomeCubitController>().loadProducts(),
          ),
      child: Column(
        spacing: 8,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xffFEEEEC),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Image.asset(
              product.image ?? 'assets/burger.png',
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'Burger',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      product.description ??
                          'Delicious burger with cheese and lettuce',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  Row(
                    spacing: 8,
                    children: [
                      Image.asset(
                        'assets/burger-icon.png',
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        product.category ?? 'Fast Food',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff868686),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Image.asset('assets/star.png', width: 20, height: 20),
                      Text(
                        '${product.rating ?? 5.0} (+${product.ratingsCount ?? 0})',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    '${product.price ?? 0.0} L.E',
                    style: TextStyle(fontSize: 16, color: Color(0xff868686)),
                  ),
                ],
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xffF55540)),

                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),

                  padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                  minimumSize: WidgetStatePropertyAll(Size(0, 0)),
                ),
                onPressed: () {},
                icon: Image.asset('assets/cart.png', height: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
