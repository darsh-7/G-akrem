import 'package:akrem/Api/test_api.dart';
import 'package:akrem/model/test_model.dart';
import 'package:get/get.dart';

class TestController extends GetxController {

  List<Products> productsList = [];

  void getProducts()async{
    productsList = await APIHandler.getData();
    print("test : \n \n ${productsList.toString()}");
    update();
  }

}