import 'package:akrem/Screens/map_screen.dart';

class Pharmacy {
  String? name;
  String? location;
  int? time;
  String? distance;


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
