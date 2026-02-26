import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/cart/controller/cart_cubit_controller.dart';
import 'package:talabat_like_app/features/cart/controller/cart_cubit_state.dart';

class IncreaseQuantityWidget extends StatelessWidget {
  const IncreaseQuantityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubitController, CartState>(
      listener: (context, state) {
        log('Current quantity: $state');
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 110,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<CartCubitController>().increment();
                      //  controller.increment();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(Icons.add, color: Color(0xffF55540)),
                    ),
                  ),
                  (state is CartLoading)
                      ? CircularProgressIndicator()
                      : (state is CartError)
                      ? Icon(Icons.error)
                      : (state is CartSuccess)
                      ? Text(
                          '${state.itemCount}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      : Text(
                          '0',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                  InkWell(
                    onTap: () {
                      context.read<CartCubitController>().decrement();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(Icons.remove, color: Color(0xffF55540)),
                    ),
                  ),
                ],
              ),
            ),
            if (state is CartError)
              Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            SizedBox(width: 60),
            Text(
              '2.20 ج.م',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ],
        );
      },
    );
  }
}
