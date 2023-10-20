import 'dart:io';
import 'dart:typed_data';

import 'package:akrem/db/user_preference.dart';
import 'package:akrem/model/medic.dart';
import 'package:akrem/model/user.dart';
import 'package:get/get.dart';




class UserController extends GetxController {


  // final basket = DonationBasket() ;
   late User user = User();

  late UserPreference _user ;

  UserController(){
    _user = UserPreference();
    //getUser();
  }

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
    user= await _user.getUser() ?? User();
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
  user = await _user.getUser() ?? User();
  update();
  print("getuser ");

  }
   Future<void> editUser(User eUser) async {
     // medics = basket.getMedics() ?? [];
     // MedicManager.medics.clear();
     await _user.editUser(eUser);
     getUser();
     update();
     print("edit user ");

   }

}
