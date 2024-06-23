import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Api/test_api.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/market_controller.dart';
import 'package:akrem/controller/test_controller.dart';
import 'package:akrem/model/market_model.dart';
import 'package:akrem/model/test_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/pharmacy_card.dart';
import '../../constants/app_colors.dart';

// import 'package:http/http.dart' as http;
// import 'package:http/retry.dart';

class TestS extends StatefulWidget {
  TestS({Key? key}) : super(key: key);

  @override
  State<TestS> createState() => _Fund();
}

class _Fund extends State<TestS> {
  final testController = Get.put(MarketController());
  final scrollController = ScrollController();

  List<MarketContent> get _productsList {
    return testController.productsList;
  }

  @override
  void initState() {
    //_foundPharmacy = pharmacyList;
    // var temp =  APIHandler.getData();
    // print("test : \n \n ${temp.toString()}");
    testController.getProducts();


    scrollController.addListener(() {

      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        testController.getProducts(end: _productsList.length+10);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Stack(
          children: [
            //Text(_productsList[0].title.toString()),

            GetBuilder<MarketController>(builder: (_) {
              return
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            bottom: 20, right: 20, left: 20, top: 10),
                        controller: scrollController,
                        itemCount: _productsList.length +1,
                        itemBuilder: (BuildContext context, int index) {

                          if(index == _productsList.length){
                            return const Center(child: CircularProgressIndicator(),);
                          }

                          return PharmacyItem(
                            pharm: Pharmacy(
                                img: _productsList[index].imagePath ??
                                    "https://i.pinimg.com/originals/e4/37/30/e437307f4baf5f8c6a9236c82886bbd4.jpg",
                                name: _productsList[index].name,
                                location: " ",
                                locName: "",
                                boxStorage: 0.0),
                          );
                        },

                      ),
                    )
                  ],
                );
            }),
          ],
        ),
      ),
    );
  }




  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      centerTitle: true,
      title: const Text("Temp Test api", style: TextStyle(color: Colors.white)),
    );
  }
}
