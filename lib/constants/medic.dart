import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'dart:math' as math;

class Medic {
  final Image img;
  final String title;
  final int? bar;
  final int? pills;
  DateTime? date;

  //String formattedDate = DateFormat('d MMMM yyyy', 'fr_FR').format(now);
  Medic({
    required this.img,
    required this.title,
    this.bar,
    this.pills,
    this.date,
  });
}

class MedicManager {
  static List<Medic> medics = [];

  static void addMedic({
    required Image img,
    required String title,
    int? bar,
    int? pills,
    DateTime? date,
  }) {
    Medic medic =
        Medic(img: img, title: title, bar: bar, pills: pills, date: date);
    medics.add(medic);
  }
}
