import 'package:akrem/model/medic.dart';
import 'package:hive/hive.dart';

class DonationBasket {
  final _boxName = "donationBasket";

  Future<Box<Medic>> get _box async => await Hive.openBox<Medic>(_boxName);

  Future<void> addMedic(Medic medic) async {
    var box = await _box;
    await box.add(medic);
  }

  Future<List<Medic>> getAll() async {
    var box = await _box;
    return box.values.toList();
  }
  Future<void> deleteAll() async {
    var box = await _box;
    box.clear();
  }
  Future<void> deleteAt(int index) async {
    var box = await _box;
    box.deleteAt(index);
  }

// Future<void> updateMedic(int index, Medic medic) async {
  //   var box = await _box;
  //
  //   //edit medic
  //   //todo: update medic
  //   await box.putAt(index, medic);
  // }
}
