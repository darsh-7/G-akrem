import 'package:akrem/Screens/map_screen.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';

class Pharmacy {
  String img;
  String? name;
  String? locName;
  String? location;
  int? time;
  int? boxStorage;
  String? phone;

  Pharmacy({
    required this.img,
    required this.name,
    required this.locName,
    required this.location,
    this.time,
    this.boxStorage,
    this.phone,
  });

  static List<Pharmacy> pharmacyList = [
    Pharmacy(
        img: AppImages.profileIcon,
        name: 'Pharmacy1Pharmacy1',
        locName: '8502 Preston Rd. Inglewood, Maine 98380',
        location: "iqkuwhdiauwdiaw12783",
        time: 15,
        boxStorage: 50,
        phone: "01012345678"),
    Pharmacy(
        img: AppImages.pharmacy,
        name: 'Pharmacy2',
        locName: 'Cairo',
        location: "iqkuwhdiauw213diaw12783",
        time: 15,
        boxStorage: 30,
        phone: "01012345678"),
    Pharmacy(
        img: AppImages.profileIcon,
        name: 'Pharmacy1Pharmacy1',
        locName: '8502 Preston Rd. Inglewood, Maine 98380',
        location: "iqkuwhdiauwdiaw12783",
        time: 15,
        boxStorage: 50,
        phone: "01012345678"),
    Pharmacy(
        img: AppImages.pharmacy,
        name: 'Pharmacy2',
        locName: 'Cairo',
        location: "iqkuwhdiauw213diaw12783",
        time: 15,
        boxStorage: 30,
        phone: "01012345678"),
  ];
}
