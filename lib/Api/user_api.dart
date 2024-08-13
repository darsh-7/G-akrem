import 'dart:convert';
import 'dart:developer';

import 'package:akrem/Api/api_key.dart';
import 'package:akrem/Api/user_api_model.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  static final UserController userController = Get.find();

  static Future<int> registerUser(String fName, String lName, String email,
      String password, String confPassword) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     akrem_url,
      //     "api/v1/products",);
      print("send:\n" +
          "FirstName : $fName LastName: $lName Email : $email Password : $password ConfirmPassword : $confPassword");

      var response = await http.post(
        Uri.parse(
          "$akrem_url" + "api/Authentication/Registeration",
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: jsonEncode({
          "firstName": fName.toString(),
          "lastName": lName.toString(),
          "email": email.toString(),
          "password": password.toString(),
          "confirmPassword": confPassword.toString(),
        }),
      );
      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");
      return response.statusCode;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  // static Future<UserApiModel> getUser(
  //     String email, String password) async {
  //   //var response = await http.get(Uri.parse(BASE_URL));
  //
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //           "http://akrem.somee.com/api/Authentication/Login",
  //         ),
  //         headers: {
  //           "content-type": "application/json",
  //           "accept": "application/json",
  //         },
  //         body: jsonEncode({
  //           "Email": email.toString(),
  //           "Password": password.toString(),
  //         }));
  //
  //     print(
  //         "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
  //     print("${response.body}");
  //
  //     var data = jsonDecode(response.body);
  //
  //     return UserApiModel.fromJson(data);
  //   } catch (error) {
  //     log("An error occurred $error");
  //     throw error.toString();
  //   }
  // }

  static Future<Map<String, dynamic>> getUser(
      String email, String password) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      var response = await http.post(
          Uri.parse(
            "$akrem_url" + "api/Authentication/Login",
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: jsonEncode({
            "Email": email.toString(),
            "Password": password.toString(),
          }));
      if (response.statusCode == 403) {
        return {'statusCode': response.statusCode};
      }

      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");

      final data = jsonDecode(response.body);
      final details = {
        'user': UserApiModel.fromJson(data),
        'statusCode': response.statusCode
      };
      return details;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<Map<String, dynamic>> getUserInfo(String? token) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      if (token == null) {
        return {'statusCode': 123};
      }
      var response = await http.get(
        Uri.parse(
          "$akrem_url" + "api/Account/GetProfile",
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${token}"
        },
      );

      if (response.statusCode == 401) {
        return {'statusCode': response.statusCode};
      }

      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");

      var data = jsonDecode(response.body);
      var details = {
        'fName': data["firstName"],
        'LName': data["lastName"],
        'email': data["email"],
        'phoneNumber': data["phoneNumber"],
        'whatsApp': data["hasWhatsApp"],
        'img': data["imageUrl"],
        'role': data["role"],
        'statusCode': response.statusCode
      };
      print("scss data ${details.toString()}");
      return details;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<void> resetPassword(String email) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      await http.get(
        Uri.parse(
          "$akrem_url" + "api/Authentication/ForgotPassword/${email}",
        ),
      );
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
      // return error.toString();
    }
  }

  static Future<void> changePhone(
      {required String phone,bool whatsApp = false ,String? token}) async {

    try {
      await http.post(
          Uri.parse(
            "$akrem_url" + "api/Account/AddNewPhoneNumber",
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "Authorization": "bearer ${userController.user.token}",
          },
          body: jsonEncode({
            "phoneNumber": phone,
            "hasWhatsApp": whatsApp
          }));
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }
  static Future<void> confirmChangePhone(
      {required String phone,required String otp, String? token}) async {

    try {
      await http.post(
          Uri.parse(
            "$akrem_url" + "api/Account/ConfirmationPhoneNumber",
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "Authorization": "bearer ${userController.user.token}",
          },
          body: jsonEncode({
            "phoneNumber": phone,
            "otp": otp
          }));
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }
  static Future<void> deleteAccount() async {
    try {
      var res = await http.get(
        Uri.parse(
          "$akrem_url" +"api/Account/DeleteAccount",
        ),
        headers: {
          // "content-type": "application/json",
          // "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
      );
      print( "$akrem_url" +"api/Account/DeleteAccount",);
      print(res.reasonPhrase);
      userController.clearUser();
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }  }

  static Future<void> changeEmail(
      {required String email, String? token}) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      var res = await http.get(
        Uri.parse(
          "$akrem_url" +"api/Account/ChangeEmail?Email=${email}",
        ),
        headers: {
          // "content-type": "application/json",
          // "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
      );
      print("$akrem_url" + "api/Account/ChangeEmail?Email=${email}");
      print(res.reasonPhrase);
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<void> changePassword(
      {required String oldPass, required String newPass, String? token}) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      await http.post(
          Uri.parse(
            "$akrem_url" + "/api/Account/ChangePassword",
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
            "Authorization": "bearer ${userController.user.token}",
          },
          body: jsonEncode({
            "currentPassword": oldPass,
            "newPassword": newPass,
            "confirmNewPassword": newPass
          }));
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<void> changeName(
      {required String fName, required String lName, String? token}) async {
    //var response = await http.get(Uri.parse(BASE_URL));
    final map = <String, dynamic>{};
    map['FirstName'] = fName;
    map['LastName'] = lName;
    try {
      var res = await http.post(
          Uri.parse(
            "$akrem_url" + "api/Account/EditProfile",
          ),
          headers: {
            //"content-type": "application/json",
           // "accept": "application/json",
            "Authorization": "bearer ${userController.user.token}",
          },
          body:{
            "FirstName" : fName,
            "LastName" : lName
          });
      print("$akrem_url" + "api/Account/EditProfile");
      print(res.reasonPhrase);
      if(res.reasonPhrase != "ok")
        throw "bad request";

    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

// static Future<List<Products>> getAllProducts({required String limit}) async {
//   List temp = await getData(
//     target: "products",
//     limit: limit,
//   );
//   return Products.productsFromSnapshot(temp);
// }
//
// static Future<List<CategoriesModel>> getAllCategories() async {
//   List temp = await getData(target: "categories");
//   return CategoriesModel.categoriesFromSnapshot(temp);
// }
//
// static Future<List<UsersModel>> getAllUsers() async {
//   List temp = await getData(target: "users");
//   return UsersModel.usersFromSnapshot(temp);
// }
//
// static Future<ProductsModel> getProductById({required String id}) async {
//   try {
//     var uri = Uri.https(
//       BASE_URL,
//       "api/v1/products/$id",
//     );
//     var response = await http.get(uri);
//
//     // print("response ${jsonDecode(response.body)}");
//     var data = jsonDecode(response.body);
//     if (response.statusCode != 200) {
//       throw data["message"];
//     }
//     return ProductsModel.fromJson(data);
//   } catch (error) {
//     log("an error occured while getting product info $error");
//     throw error.toString();
//   }
// }
}
