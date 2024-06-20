import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Api/test_api.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/test_controller.dart';
import 'package:akrem/model/test_model.dart';
import 'package:akrem/widgets/reword_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// import 'package:http/http.dart' as http;
// import 'package:http/retry.dart';

class Reword extends StatefulWidget {
  Reword({Key? key}) : super(key: key);

  @override
  State<Reword> createState() => _Reword();
}

class _Reword extends State<Reword> {
  final testController = Get.put(TestController());
  final scrollController = ScrollController();

  List<Products> get _productsList {
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

            GetBuilder<TestController>(builder: (_) {
              return
              Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 20, left: 20, top: 10),
                      controller: scrollController,
                      itemCount: _productsList.length +1,
                      separatorBuilder: (BuildContext context, int index) {

                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {

                        if(index == _productsList.length){
                          return const Center(child: CircularProgressIndicator(),);
                        }

                        return VerticalCouponExample();
                        //   PharmacyItem(
                        //   pharm: Pharmacy(
                        //       img: _productsList[index].images?[0] ??
                        //           "https://i.pinimg.com/originals/e4/37/30/e437307f4baf5f8c6a9236c82886bbd4.jpg",
                        //       name: _productsList[index].title,
                        //       location: " ",
                        //       locName: "",
                        //       boxStorage: 0.0),
                        // );
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Rewards"),
          const SizedBox(width: 8),

          const Text("123"),

        ],
      ),
    );
  }
}
