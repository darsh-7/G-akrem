import 'dart:ffi';

import 'package:akrem/model/medic.dart';
import 'package:akrem/model/user.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserPreference {
  final _boxName = "User";

  late Box _box;

  UserPreference() {
    // for(int i = 1 ;box.values.toList()[0] )

    openBox();
  }

  Future<void> openBox() async {
    _box = await Hive.openBox(_boxName);
  }

  Future<void> newUser(User user) async {
    _box.put(_boxName, user);

    // var box = await _box;
    // box.clear();
    // box.add(user);
  }

  // Future<void> editUser(User user) async {
  //   var box = await _box;
  //   box.values.toList()[0] = user ;
  // }

  Future<User?> getUser() async {
    _box = await Hive.openBox(_boxName);
    return _box.get(_boxName);
  }
  Future<User?> registerUser() async {
    return _box.get(_boxName);
  }

  Future<void> editUser(User user) async {
    User? oldUser = await _box.get(_boxName);

    final User nUser = User(
        fName: user.fName ?? oldUser?.fName,
        lName: user.lName ?? oldUser?.lName,
        email: user.email ?? oldUser?.email,
        locationLatitude: user.locationLatitude ?? oldUser?.locationLatitude,
        locationLongitude: user.locationLongitude ?? oldUser?.locationLongitude,
        locationString: user.locationString ?? oldUser?.locationString,
        darkTheme: user.darkTheme,
        phone: user.phone ?? oldUser?.phone,
        token: user.token ?? oldUser?.token);

    print("email edit objet ${nUser.email}");

    _box.put(_boxName, nUser);
  }

  Future<void> deleteUser() async {
    var box = await _box;
    box.clear();
  }
}
