import 'dart:io';

import 'package:hive/hive.dart';

import 'package:hive/hive.dart';
part 'medic.g.dart';
@HiveType(typeId: 2)
class Medic {
 // final int id;
  @HiveField(0)
  final File img;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int? bar;

  @HiveField(3)
  final int? pill;

  @HiveField(4)
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
