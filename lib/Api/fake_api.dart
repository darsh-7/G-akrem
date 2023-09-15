import 'package:akrem/Screens/map_screen.dart';

class Pharmacy {
  String? name;
  String? location;
  int? time;
  String? distance;
//https://youtu.be/NkRkuI0ZgX0?t=147

  Pharmacy({
    required this.name,
    required this.location,
    this.time,
    this.distance,
  });

  static List<Pharmacy> pharmacyList() {
    return [
      Pharmacy(name: 'Pharmacy1', location: 'cairo', time: 15 , distance: "15M"),
      Pharmacy(name: 'Pharmacy1', location: 'cairo', time: 15 , distance: "15M"),
      Pharmacy(name: 'Pharmacy1', location: 'cairo', time: 15 , distance: "15M"),
      Pharmacy(name: 'Pharmacy1', location: 'cairo', time: 15 , distance: "15M"),
      Pharmacy(name: 'Pharmacy1', location: 'cairo', time: 15 , distance: "15M"),
      Pharmacy(name: 'Pharmacy2', location: 'Morning Excercise', time: 15 , distance: "15M"),
      Pharmacy(name: 'Pharmacy2', location: 'Morning Excercise', time: 15 , distance: "15M"),
    ];
  }
}
