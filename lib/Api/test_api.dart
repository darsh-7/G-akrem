import 'dart:convert';
import 'dart:developer';

import 'package:akrem/Api/api_key.dart';
import 'package:akrem/model/test_model.dart';
import 'package:http/http.dart' as http;

// import 'package:store_api_flutter_course/consts/api_consts.dart';
// import 'package:store_api_flutter_course/models/categories_model.dart';
// import 'package:store_api_flutter_course/models/products_model.dart';
// import 'package:store_api_flutter_course/models/users_model.dart';


class APIHandler {

  static Future<List<Products>> getData() async {

    //var response = await http.get(Uri.parse(BASE_URL));


    try {
      // final uri = Uri.https(
      //     BASE_URL,
      //     "api/v1/products",);
      // var response = await http.get(uri);
      var response = await http.get(Uri.parse("$BASE_URL"+"api/v1/products?offset=0&limit=10"));
      // print("response : ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List tempList = [];
      if (response.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
        // print("V $v \n\n");
      }
      return Products.productsFromSnapshot(tempList);
    } catch (error) {
      log("An error occured $error");
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
