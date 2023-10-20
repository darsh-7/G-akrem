import 'dart:convert';
import 'dart:developer';

import 'package:akrem/Api/api_key.dart';
import 'package:akrem/Api/user_api_model.dart';
import 'package:http/http.dart' as http;

class UserAPI {
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

  static Future<UserApiModel> getUser(
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

      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");

      var data = jsonDecode(response.body);


      return UserApiModel.fromJson(data);
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
