import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'medic.g.dart';
@HiveType(typeId: 2)
class Medic {
 // final int id;
  @HiveField(0)
  final Uint8List img;

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

