import 'dart:convert';
import 'dart:developer';

import 'package:akrem/Api/api_key.dart';
import 'package:akrem/Api/user_api_model.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/market_model.dart';
import 'package:akrem/model/order_history.dart';
import 'package:akrem/model/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MarketAPI {
  static final UserController userController = Get.find();

  static Future<List<MarketContent>> getMedicine({int? start, int? end}) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     BASE_URL,
      //     "api/v1/products",);
      // var response = await http.get(uri);
      var response;
      if (end == null)
        response = await http.get(Uri.parse(akrem_url + getMedicationMarket));
      else
        response = await http.get(
            Uri.parse("$akrem_url" + getMedicationMarket + "?pageSize=$end"));
      print("response : ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List<MarketContent> tempList = [];
      // if (response.statusCode != 200) {
      //   throw data["error"];
      // }
      for (var v in data["content"]) {
        tempList.add(MarketContent(
            id: v["id"] as int,
            name: v["name"] as String,
            price: v["price"] as double,
            imagePath: v["imagePath"] as String,
            totalQuantity: v["totalQuantity"] as int,
            priceAfterDiscount: v["priceAfterDiscount"] as double

        ));
        // print("V $v \n\n");
      }
      //return MarketContent.fromJson(data["content"]);
      return tempList;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<bool> addMedicineToCart(int id) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     BASE_URL,
      //     "api/v1/products",);
      // var response = await http.get(uri);
      var response;
        response = await http.post(Uri.parse(akrem_url + "api/Cart/AddProductToShoppingCart?marketMedicineId=$id"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
          },
        // body: jsonEncode({
        //   "marketMedicineId": id,
        // }),
        );
      //print("response : ${jsonDecode(response.body)}");
     // var data = jsonDecode(response.body);
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }


  static Future<int> supOrder(
      double latitude,
      double  longitude,
      String address,
      String phoneNumber,) async {
    //var response = await http.get(Uri.parse(BASE_URL));


    try {

      print("send:\n" +
          "latitude: $latitude\n" + "longitude: $longitude\n" + "address: $address\n" + "phoneNumber: $phoneNumber\n");

      var response = await http.post(
        Uri.parse(
          "$akrem_url" + "api/Orders/CreateShoppingOrder",
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
        body: jsonEncode({

        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "address": address.toString(),
        "areaId": 1,
        "phoneNumber": phoneNumber.toString()
        }),
      );
      print(
          "create order respond : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");
      return response.statusCode;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }


  static Future<bool> cancelOrder() async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     BASE_URL,
      //     "api/v1/products",);
      // var response = await http.get(uri);
      var response;
      response = await http.post(Uri.parse(akrem_url + "api/Orders/DeleteLastShoppingOrders"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
        // body: jsonEncode({
        //   "marketMedicineId": id,
        // }),
      );
      //print("response : ${jsonDecode(response.body)}");

      //return MarketContent.fromJson(data["content"]);
      return response.statusCode == 200;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<bool> checkUpComingOrder() async {
    //var response = await http.get(Uri.parse(BASE_URL));


    try {

      var response = await http.post(
        Uri.parse(
          "$akrem_url" + "api/Orders/CheckHavingOrder",
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
      );

      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");
      return response.body == "true";
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }



  static Future<List<OrdeHistory>> orderHistory() async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     BASE_URL,
      //     "api/v1/products",);
      // var response = await http.get(uri);
      var response = await http.get(
            Uri.parse("$akrem_url" + "api/Orders/GetAll"));
      print("response : ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List<OrdeHistory> tempList = [];
      // if (response.statusCode != 200) {
      //   throw data["error"];
      // }
      for (var v in data["content"]) {
        tempList.add(OrdeHistory(
            id: v["id"] as int,
            orderStatuses: v["orderStatuses"] as int,
            address: v["address"] as String,
            phoneNumber:  v["phoneNumber"] as String,
            arrivedDate: v["arrivedDate"] as String,
        ));
        // print("V $v \n\n");
      }
      //return MarketContent.fromJson(data["content"]);
      return tempList;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }


}