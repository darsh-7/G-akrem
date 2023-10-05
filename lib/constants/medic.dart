import 'dart:async';
import 'dart:io';

import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'dart:math' as math;

class Medic {
 // final int id;
  final File img;
  final String name;
  final int? bar;
  final int? pill;
  final DateTime? date;

  //String formattedDate = DateFormat('d MMMM yyyy', 'fr_FR').format(now);
  Medic({
    required this.img,
    required this.name,
    this.bar,
    this.pill,
    this.date,
  });
}

class MedicManager {
  //todo : add to local storage
  static List<Medic> medics = [
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
  ];

  static void removeMedic({
    required int index,
  }) {
    medics.removeAt(index);
  }

  static void addMedic({
    required File img,
    required String name,
    int? bar,
    int? pills,
    DateTime? date,
  }) {
    Medic medic =
        Medic(img: img, name: name, bar: bar, pill: pills, date: date);
    medics.add(medic);
  }
}
