import 'dart:io';

import 'package:akrem/constants/medic.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  List<Medic> medics = MedicManager.medics;


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
    //MedicManager.medics.removeAt(index);
    print("removed item $index");
    update();
  }

  void addMedic({
    required File img,
    required String name,
    int? bar,
    int? pills,
    DateTime? date,
  }) {
    Medic medic =
        Medic(img: img, name: name, bar: bar, pill: pills, date: date);
    medics.add(medic);
   // MedicManager.medics.add(medic);
    update();
    print("addMedic $medic");

  }

  void clearList() {
    medics.clear();
   // MedicManager.medics.clear();
    update();
    print("clearList ");

  }
}
