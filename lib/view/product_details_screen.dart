import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = 'product_details_screen';
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product details')),
      body: Center(child: Text('Product details')),
    );
  }
}
