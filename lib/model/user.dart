import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? img;
  @HiveField(1)
  String? fName;
  @HiveField(2)
  String? lName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  double? locationLatitude;
  @HiveField(5)
  double? locationLongitude;

  @HiveField(6)
  String? locationString;
  @HiveField(7)
  bool? darkTheme;
  @HiveField(8)
  String? token;
  @HiveField(9)
  String? phone;
  @HiveField(10)
  bool? whatsapp;

  User({
    this.img,
    this.fName,
    this.lName,
    this.email,
    this.locationLatitude,
    this.locationLongitude,
    this.locationString,
    this.darkTheme,
    this.token,
    this.phone,
    this.whatsapp,
  });

  LatLng? getLocation() {
    if (locationLatitude == null || locationLongitude == null) {
      return null;
    }
    return LatLng(locationLatitude ?? 0, locationLongitude ?? 0);
  }

// User.fromJson(Map<String, dynamic> json) {
//  // id = json['id'];
//   fName = json['FirstName'];
//   lName = json['LastName '];
//   email = json['Email '];
// }
}
