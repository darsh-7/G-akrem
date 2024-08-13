
import 'package:akrem/Api/user_api.dart';
import 'package:akrem/db/user_preference.dart';
import 'package:akrem/model/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // final basket = DonationBasket() ;
  late User user = User();

  late UserPreference _user;

  UserController() {
    _user = UserPreference();
    //getUser();
  }

  Future<void> newUser(User newUser) async {
    _user.newUser(newUser);
    user = await _user.getUser() ?? User();
    update();
    print("newUser called $user");
  }

  void clearUser() {
    _user.deleteUser();
    // MedicManager.medics.clear();
    update();
    print("clearList ");
  }

  Future<void> getUser() async {
    // medics = basket.getMedics() ?? [];
    // MedicManager.medics.clear();
    user = await _user.getUser() ?? User();
    update();
    print("getuser ");
  }

  Future<void> editUser(User eUser) async {
    // medics = basket.getMedics() ?? [];
    // MedicManager.medics.clear();
    await _user.editUser(eUser);
    user = await _user.getUser() ?? User();
    update();
    print("edit email ${user.email} ");
  }

  Future<void> fetchNewUser() async {
    final newUser = await UserAPI.getUserInfo(user.token);

    // await newUser(User(
    //     img: newUser["img"],
    //     fName: newUser["fName"],
    //     lName: newUser["LName"],
    //     email: newUser["email"],
    //     whatsapp: newUser["whatsApp"],
    //     phone: newUser["phone"],
    //     token: user.token));

    await _user.editUser(User(
        img: newUser["img"],
        fName: newUser["fName"],
        lName: newUser["LName"],
        email: newUser["email"],
        whatsapp: newUser["whatsApp"],
        phone: newUser["phoneNumber"],
        token: user.token));

    user = await _user.getUser() ?? User();
    update();
    print("edit email ${newUser["phoneNumber"]} 0000000000000000000000000000000");
  }
}
