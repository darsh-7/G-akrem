import 'package:akrem/model/item.dart';
import 'package:flutter/material.dart';


class Cart with ChangeNotifier {
  List<Product> selectedProducts = items;
  int price = 0;

  add(Product products) {
    selectedProducts.add(products);
    price += products.price.round();
    notifyListeners();
  }

  delete(Product products) {
    selectedProducts.remove(products);
    price -= products.price.round();
    notifyListeners();
  }
}
