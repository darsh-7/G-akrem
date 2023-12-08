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
     user = await _user.getUser() ?? User();
     update();
     print("edit email ${user.email} ");

   }

}
