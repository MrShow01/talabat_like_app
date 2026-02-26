import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  int itemCount = 0;
  double totalPrice = 0.0;
  bool isLoading = false;
  void calculateTotalPrice() {
    totalPrice = itemCount * 2.20; // Assuming each item costs 2.20
    isLoading = false;
    notifyListeners();
  }

  void addItem() {
    isLoading = true;
    notifyListeners();
    itemCount++;
    calculateTotalPrice();
  }

  void removeItem() {
    isLoading = true;
    notifyListeners();
    if (itemCount > 0) {
      itemCount--;
      calculateTotalPrice();
    }
    notifyListeners();
  }
}
