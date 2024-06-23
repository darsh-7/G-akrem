import 'package:akrem/Api/market.dart';
import 'package:akrem/Api/test_api.dart';
import 'package:akrem/model/market_model.dart';
import 'package:akrem/model/test_model.dart';
import 'package:get/get.dart';

class MarketController extends GetxController {

  List<MarketContent> productsList= [];

  void getProducts({int? start,int? end})async{
    productsList = await MarketAPI.getMedicine(end: end,start: start);
    print("test : \n ${productsList.toString()}");
    update();
  }

}