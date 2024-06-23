import 'package:akrem/Api/locations.dart';
import 'package:akrem/Api/market.dart';
import 'package:akrem/Api/test_api.dart';
import 'package:akrem/model/boxes.dart';
import 'package:akrem/model/market_model.dart';
import 'package:akrem/model/test_model.dart';
import 'package:get/get.dart';

class BoxesController extends GetxController {

  List<BoxContent> productsList= [];

  void getBoxes({int? start,int? end})async{
    productsList = await LocationAPI.getBoxes();
    print("boxes : \n ${productsList.toString()}");
    update();
  }

}