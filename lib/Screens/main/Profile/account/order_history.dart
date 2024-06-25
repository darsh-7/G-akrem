import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Api/market.dart';
import 'package:akrem/Api/test_api.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/test_controller.dart';
import 'package:akrem/model/test_model.dart';
import 'package:akrem/widgets/history_card.dart';
import 'package:akrem/widgets/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/order_history.dart';


// import 'package:http/http.dart' as http;
// import 'package:http/retry.dart';

class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _Fund();
}

class _Fund extends State<OrderHistoryPage> {
  final testController = Get.put(TestController());
  final scrollController = ScrollController();

  List<OrdeHistory> _productsList = [];

  @override
  void initState() {
    //_foundPharmacy = pharmacyList;
    // var temp =  APIHandler.getData();
    // print("test : \n \n ${temp.toString()}");

    MarketAPI.orderHistory().then((value) {
      _productsList = value;
      print("_productsList $value");
      setState(() {});
    });
    //
    // DonationApi.checkUpComingDonation().then((value) {
    //   upcomingDonation = value;
    //   print("upcomingDonation $upcomingDonation");
    //   setState(() {});
    // });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          //Text(_productsList[0].title.toString()),

          GetBuilder<TestController>(builder: (_) {
            return
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        bottom: 20, right: 20, left: 20, top: 10),
                    controller: scrollController,
                    itemCount: _productsList.length ,
                    itemBuilder: (BuildContext context, int index) {

                      if(0 == _productsList.length){
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      return HistoryCard(
                        title: _productsList[index].id.toString(),
                        id: _productsList[index].orderStatuses.toString(),
                        phoneNumber: _productsList[index].phoneNumber.toString(),
                        arrivedDate: _productsList[index].address.toString(),
                        address: _productsList[index].address.toString(),
                        orderStatuses: _productsList[index].orderStatuses??0,
                      );

                    },

                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }




  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      centerTitle: true,
      title: const Text("Order history", style: TextStyle(color: Colors.white)),
    );
  }
}

class DonationHistory{
  final String id;
  final String orderStatuses;
  final String address;
  final double phoneNumber;

  DonationHistory({
    required this.id,
    required this.orderStatuses,
    required this.address,
    required this.phoneNumber,
  });
}

