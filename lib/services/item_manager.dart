// import 'package:flutter/material.dart';
//
//
// class GroceryManager extends ChangeNotifier {
//   final _groceryItems = <GroceryItem>[];
//   List<GroceryItem> get groceryItem => List.unmodifiable(_groceryItems);
//
//   void deleteItem(int index) {
//     _groceryItems.removeAt(index);
//     notifyListeners();
//   }
//
//   void addItem(GroceryItem item) {
//     _groceryItems.add(item);
//     notifyListeners();
//   }
//
//   void updateItem(GroceryItem item, int index) {
//     _groceryItems[index] = item;
//     notifyListeners();
//   }
//
//
// }
