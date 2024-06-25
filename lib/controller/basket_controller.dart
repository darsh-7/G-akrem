import 'dart:io';
import 'dart:typed_data';

import 'package:akrem/model/medic.dart';
import 'package:akrem/db/basket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {


 // final basket = DonationBasket() ;
  List<Medic> medics = [];
  final DonationBasket _basket = DonationBasket();

  // [
    // Medic(
    //     img: Image.asset(AppImages.pharmacy),
    //     name: 'item1',
    //     bar: 1,
    //     pill: 2,
    //     date: DateTime.now()),
    // Medic(
    //     img: Image.asset(AppImages.pharmacy),
    //     name: 'item1',
    //     bar: 1,
    //     pill: 2,
    //     date: DateTime.now()),
    // Medic(
    //     img: Image.asset(AppImages.pharmacy),
    //     name: 'item1',
    //     bar: 1,
    //     pill: 2,
    //     date: DateTime.now()),
  // ];

  void removeMedic({
    required int index,
  }) {
    medics.removeAt(index);
    _basket.deleteAt(index);
    //MedicManager.medics.removeAt(index);
    print("removed item $index");
    update();
  }

  Future<void> addMedic({
    required Uint8List img,
    required String name,
    int? bar,
    int? pills,
    DateTime? date,
    int? medtyp,
  }) async {
    Medic medic =
        Medic(img: img, name: name, bar: bar, pill: pills, date: date,medtyp: medtyp);
    await _basket.addMedic(medic);
    medics.add(medic);
   // MedicManager.medics.add(medic);
   //  basket.addMedic(medic);
    update();
    print("addMedic $medic");
  }

  bool clearList() {
    _basket.deleteAll();
    medics.clear();
   // MedicManager.medics.clear();
    update();
    print("clearList ");
    return true;
  }
  Future<void> getMedics() async {
    // medics = basket.getMedics() ?? [];
    // MedicManager.medics.clear();
    medics = await _basket.getAll();

    update();
    print("getMedics ");

  }

}
