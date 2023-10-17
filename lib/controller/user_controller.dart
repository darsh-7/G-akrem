// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:akrem/db/user_preference.dart';
// import 'package:akrem/model/medic.dart';
// import 'package:akrem/model/user.dart';
// import 'package:get/get.dart';
//
// class UserController extends GetxController {
//
//
//   // final basket = DonationBasket() ;
//   late User user ;
//   final UserPreference _user = UserPreference();
//
//   // [
//   // Medic(
//   //     img: Image.asset(AppImages.pharmacy),
//   //     name: 'item1',
//   //     bar: 1,
//   //     pill: 2,
//   //     date: DateTime.now()),
//   // Medic(
//   //     img: Image.asset(AppImages.pharmacy),
//   //     name: 'item1',
//   //     bar: 1,
//   //     pill: 2,
//   //     date: DateTime.now()),
//   // Medic(
//   //     img: Image.asset(AppImages.pharmacy),
//   //     name: 'item1',
//   //     bar: 1,
//   //     pill: 2,
//   //     date: DateTime.now()),
//   // ];
//
//   void removeUser({
//     required int index,
//   }) {
//     user.;
//     _user.deleteUser();
//     //MedicManager.medics.removeAt(index);
//     print("removed item $index");
//     update();
//   }
//
//   Future<void> addMedic({
//     required Uint8List img,
//     required String name,
//     int? bar,
//     int? pills,
//     DateTime? date,
//   }) async {
//     Medic medic =
//     Medic(img: img, name: name, bar: bar, pill: pills, date: date);
//     await _user.addMedic(medic);
//     medics.add(medic);
//     // MedicManager.medics.add(medic);
//     //  basket.addMedic(medic);
//     update();
//     print("addMedic $medic");
//   }
//
//   void clearUser() {
//     _user.deleteUser();
//     user.clear();
//     // MedicManager.medics.clear();
//     update();
//     print("clearList ");
//   }
//   Future<void> getUser() async {
//     // medics = basket.getMedics() ?? [];
//     // MedicManager.medics.clear();
//     user =  await _user.getUser();
//     update();
//     print("getMedics ");
//
//   }
//
// }
