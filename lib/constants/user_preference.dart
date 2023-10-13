import 'package:akrem/Screens/map/map_screen.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';

class UserPreference {
  String? img;
  String name;
  String? email;
  String? location;
  bool darkTheme;
  String? token;
  String? phone;

  UserPreference({
    this.img,
    this.name = "",
    this.email,
    this.location,
    this.darkTheme = false,
    this.token,
    this.phone,
  });

//   static UserPreference User = UserPreference(
//       img:
//           "https://i.pinimg.com/originals/e4/37/30/e437307f4baf5f8c6a9236c82886bbd4.jpg",
//       name: 'Pharmacy1Pharmacy1',
//       locName: '8502 Preston Rd. Inglewood, Maine 98380',
//       location: "iqkuwhdiauwdiaw12783",
//       time: 15,
//       boxStorage: 0.6,
//       phone: "01012345678");
}
