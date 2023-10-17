import 'dart:ffi';

import 'package:akrem/model/medic.dart';
import 'package:akrem/model/user.dart';
import 'package:hive/hive.dart';

class UserPreference {
  final _boxName = "user";

  Future<Box<User>> get _box async => await Hive.openBox<User>(_boxName);

  Future<void> newUser(User user) async {
    var box = await _box;
    box.values.toList()[0] = user ;
  }

  Future<User> getUser() async {
    var box = await _box;
    return box.values.toList()[0];
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
