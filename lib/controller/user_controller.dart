import 'dart:io';
import 'dart:typed_data';

import 'package:akrem/db/user_preference.dart';
import 'package:akrem/model/medic.dart';
import 'package:akrem/model/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {


  // final basket = DonationBasket() ;
  late User user = User();

  final UserPreference _user = UserPreference();

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

  Future<void> newUser(User newUser) async {

    _user.newUser(newUser);
    user= await _user.getUser();
  update();
  print("newUser called $user");
  }

  void clearUser() {
  _user.deleteUser();
  // MedicManager.medics.clear();
  update();
  print("clearList ");
  }
  Future<void> getUser() async {
  // medics = basket.getMedics() ?? [];
  // MedicManager.medics.clear();
  user = await _user.getUser();
  update();
  print("getMedics ");

  }

}
