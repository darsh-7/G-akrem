import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 1)
class User {
  @HiveField(0)
  Uint8List? img;
  @HiveField(1)
  String? fName;
  @HiveField(2)
  String? lName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  LatLng? location;
  @HiveField(5)
  String? locationString;
  @HiveField(6)
  bool darkTheme= false;
  @HiveField(7)
  String? token;
  @HiveField(8)
  String? phone;


  User({
    this.img,
    this.fName = "User",
    this.lName = "",
    this.email,
    this.location,
    this.locationString,
    this.darkTheme = false,
    this.token,
    this.phone,
  });


  // User.fromJson(Map<String, dynamic> json) {
  //  // id = json['id'];
  //   fName = json['FirstName'];
  //   lName = json['LastName '];
  //   email = json['Email '];
  // }

}

