import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 1)
class User {
  @HiveField(1)
  LatLng? location;

  @HiveField(2)
  bool darkTheme= false;

  @HiveField(3)
  String? token;


  User({
    this.location,
    this.darkTheme = false,
    this.token,
  });


  // User.fromJson(Map<String, dynamic> json) {
  //  // id = json['id'];
  //   fName = json['FirstName'];
  //   lName = json['LastName '];
  //   email = json['Email '];
  // }

}

