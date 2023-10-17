import 'dart:convert';
import 'dart:developer';

import 'package:akrem/Api/api_key.dart';
import 'package:http/http.dart' as http;

// import 'package:store_api_flutter_course/consts/api_consts.dart';
// import 'package:store_api_flutter_course/models/categories_model.dart';
// import 'package:store_api_flutter_course/models/products_model.dart';
// import 'package:store_api_flutter_course/models/users_model.dart';

class UserAPI {
  static Future<int> registerUser(String fName, String lName, String email,
      String password, String confPassword) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     akrem_url,
      //     "api/v1/products",);
      // print("send:\n" +
      //     "FirstName : $fName LastName: $lName Email : $email Password : $password ConfirmPassword : $confPassword");
      //
      var response = await http.post(
          Uri.parse(
            "$akrem_url" + "api/Authentication/Registeration",
          ),
          body: {
            'FirstName': fName.toString(),
            'LastName': lName.toString(),
            "Email": email.toString(),
            "Password": password.toString(),
            "ConfirmPassword": confPassword.toString(),
          });

      // print(
      //     "post : ${response.headers}\n else: ${response.persistentConnection}");
      print("${response.body}");
      return response.statusCode;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<Map<String, dynamic>> getUser(
      String email, String password) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      var response = await http.post(
          Uri.parse(
            "$akrem_url" + "api/Authentication/Login",
          ),
          body: {
            "Email": email.toString(),
            "Password": password.toString(),
          });

      // print(
      //     "post : ${response.headers}\n else: ${response.persistentConnection}");

      print("${response.body}");
      var data = jsonDecode(response.body);

      return <String, dynamic>{
        "statusCode": response.statusCode,
        "token": data["token"],
        "expireOn": data["expireOn"],
        "roles": data["roles"],
      };
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
