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
      Pharmacy(name: 'Pharmacy1', location: '8502 Preston Rd. Inglewood, Maine 98380', time: 15 , distance: "15"),
      Pharmacy(name: 'Pharmacy2', location: 'cairo', time: 15 , distance: "15"),
      Pharmacy(name: 'Pharmacy3', location: '8502 Preston Rd. Inglewood, Maine 98380', time: 15 , distance: "15"),
      Pharmacy(name: 'Pharmacy4', location: 'cairo', time: 15 , distance: "15"),
      Pharmacy(name: 'Pharmacy5', location: 'cairo', time: 15 , distance: "15"),
      Pharmacy(name: 'Pharmacy6', location: '8502 Preston Rd. Inglewood, Maine 98380', time: 15 , distance: "15"),
      Pharmacy(name: 'Pharmacy7', location: 'Morning Excercise', time: 15 , distance: "15"),
    ];
  }
}
