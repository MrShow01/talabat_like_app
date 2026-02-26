import 'package:flutter/material.dart';
import 'package:talabat_like_app/view/page_3.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = 'product_details_screen';
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product details')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Drawer header')),
            ListTile(
              title: Text('Go to page 3'),
              onTap: () {
                Navigator.of(context).pushNamed(Page3Screen.routeName);
              },
            ),
            ListTile(
              title: Text('Go to page 3'),
              onTap: () {
                Navigator.of(context).pushNamed(Page3Screen.routeName);
              },
            ),
            ListTile(
              title: Text('Go to page 3'),
              onTap: () {
                Navigator.of(context).pushNamed(Page3Screen.routeName);
              },
            ),
            ListTile(
              title: Text('Go to page 3'),
              onTap: () {
                Navigator.of(context).pushNamed(Page3Screen.routeName);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product details'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Page3Screen()));
              },
              child: Text('push to Screen 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Page3Screen()),
                );
              },
              child: Text('push and replace to Screen 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Page3Screen()),
                  (route) => false,
                );
              },
              child: Text('push and remove all to Screen 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Page3Screen.routeName);
              },
              child: Text('push named to Screen 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushReplacementNamed(Page3Screen.routeName);
              },
              child: Text('push and replace named to Screen 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Page3Screen.routeName,
                  (route) => false,
                );
              },
              child: Text('push and remove all named to Screen 3'),
            ),
          ],
        ),
      ),
    );
  }
}
