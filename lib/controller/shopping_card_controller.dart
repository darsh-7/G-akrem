import 'dart:io';
import 'dart:typed_data';

import 'package:akrem/model/medic.dart';
import 'package:akrem/db/basket.dart';
import 'package:akrem/model/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCardController extends GetxController {


  // final basket = DonationBasket() ;
  List<ShoppingCartModel> cart = [];
 // final DonationBasket _basket = DonationBasket();


  void removeItem({
    required int id,
    bool forceDelete = false,
  }) {
    if(forceDelete){
      cart.removeWhere((element) => element.id == id);
      update();
      return;
    }
    if(cart.any((element) => element.id == id)){
      if(cart.firstWhere((element) => element.id == id).quantity ==1){
        return;
      }
      cart.firstWhere((element) => element.id == id).quantity--;
      update();
      return;
    }
  }

  void addMedic({
    //required Uint8List img,
    required int id,
    required String ImageUrl,
    required String name,
    required double price,
  }) {

    if(cart.any((element) => element.id == id)){
      cart.firstWhere((element) => element.id == id).quantity++;
      update();
      return;
    }

    ShoppingCartModel medic =
    ShoppingCartModel(id: id, name: name, image: ImageUrl, price: price, quantity: 1);
   // await _basket.addMedic(medic);
    cart.add(medic);
    // MedicManager.medics.add(medic);
    //  basket.addMedic(medic);
    update();
    print("addMedic $medic");
  }

  void clearList() {
   // _basket.deleteAll();
    cart.clear();
    // MedicManager.medics.clear();
    update();
    print("clearList ");

  }

  Future<void> getMedics() async {
    // medics = basket.getMedics() ?? [];
    // MedicManager.medics.clear();
   // medics = await _basket.getAll();

    update();
    print("getMedics ");

  }

  double getPrice(){
    double total = 0;
    cart.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

}
