









//
// import 'package:akrem/constants/medic.dart';
// import 'package:get_storage/get_storage.dart';
//
// class DonationBasket{
//   var donations = GetStorage();
//   void addMedic(Medic newMedic){
//     if (donations.read('donations')== null ) {
//       List<Medic> dons = [newMedic];
//       donations.write('donations',dons);
//       return;
//     }
//     List<Medic> dons = donations.read('donations');
//     dons.add(newMedic);
//     donations.write('donations',dons);
//   }
//
//   List<Medic>? getMedics(){
//
//
//
//     return donations.read('donations');
//   }
//   void removeMedic(int index) {
//     List<Medic> dons = donations.read('donations');
//     dons.removeAt(index);
//     donations.write('donations',dons);
//   }
// }