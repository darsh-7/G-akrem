import 'dart:convert';
import 'dart:developer';

import 'package:akrem/Api/api_key.dart';
import 'package:akrem/Api/user_api_model.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/market_model.dart';
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
            totalQuantity: v["totalQuantity"] as int
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