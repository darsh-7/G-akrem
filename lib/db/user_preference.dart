import 'dart:ffi';

import 'package:akrem/model/medic.dart';
import 'package:akrem/model/user.dart';
import 'package:hive/hive.dart';

class UserPreference {
  final _boxName = "user";

  //Future<Box<User>> get _box async => await Hive.openBox<User>(_boxName);
  late Box _box ;

 UserPreference(){
   // for(int i = 1 ;box.values.toList()[0] )

   newbox();
}
  Future<void> newbox() async {
    _box = await Hive.openBox(_boxName);
  }

  Future<void> newUser(User user) async {
   _box.put("User", user);
    // var box = await _box;
    // box.clear();
    // box.add(user);
  }
  // Future<void> editUser(User user) async {
  //   var box = await _box;
  //   box.values.toList()[0] = user ;
  // }

  Future<User> getUser() async {

    // var box = await _box;
    // return box.values.toList()[0];
    return _box.get("User");
  }
  Future<void> deleteUser() async {
    var box = await _box;
    box.clear();
  }


// Future<void> updateMedic(int index, Medic medic) async {
//   var box = await _box;
//
//   //edit medic
//   //todo: update medic
//   await box.putAt(index, medic);
// }
}
