import 'package:akrem/Api/test_api.dart';
import 'package:akrem/model/test_model.dart';
import 'package:get/get.dart';

class TestController extends GetxController {

  List<Products> productsList = [];

  void getProducts({int? start,int? end})async{
    productsList = await APIHandler.getData(end: end,start: start);
    print("test : \n \n ${productsList.toString()}");
    update();
  }

}