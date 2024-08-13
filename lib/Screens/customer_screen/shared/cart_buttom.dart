import 'package:akrem/controller/shopping_card_controller.dart';
import 'package:akrem/model/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ShoppingCardController shoppingCardController = Get.find();

List<ShoppingCartModel> get _foundMedic {
  return shoppingCardController.cart;
}

Widget customShoppingCart() {
  return Stack(
    children: <Widget>[
      Icon(
        Icons.shopping_cart,
      ),
      GetBuilder<ShoppingCardController>(builder: (_) {
        if (_foundMedic.length == 0) {
          return SizedBox();
        } else
          return Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Center(
                child: Text(
                  _foundMedic.length.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
      }),
    ],
  );
}
