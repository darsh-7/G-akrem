import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/widgets/appbarr.dart';
import 'package:flutter/material.dart';
import '../widgets/pharmacy_card.dart';
import '../constants/app_colors.dart';
import 'dart:math' as math;

class ShowBranch extends StatefulWidget {
  ShowBranch({Key? key}) : super(key: key);

  @override
  State<ShowBranch> createState() => _ShowBranchState();
}

class _ShowBranchState extends State<ShowBranch> {
  final pharmacyList = Pharmacy.pharmacyList;
  List<Pharmacy> _foundPharmacy = [];
  Image image = Image.asset(AppImages.profileIcon);

  @override
  void initState() {
    _foundPharmacy = pharmacyList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      extendBodyBehindAppBar: false,
      appBar: _buildAppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // leading: IconButton(
              //   icon: const Icon(Icons.arrow_back),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              // ),
              title: Container(
                color: Colors.transparent,
                child: searchBox(),

                // const Text("Donation branch's")
              ),
              centerTitle: true,
              elevation: 10.0,
              automaticallyImplyLeading: false,
              expandedHeight: 50,
              floating: true,
              snap: true,
              backgroundColor: AppColors.mainColor,
            ),
            SliverAppBar(
              title: Container(
                color: Colors.transparent,
                child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("data"),
                      Text("data"),
                    ],
                  ),

                // const Text("Donation branch's")
              ),
              centerTitle: true,
              elevation: 10.0,
              automaticallyImplyLeading: false,
              expandedHeight: 50,
              floating: true,
              snap: true,
              backgroundColor: AppColors.mainColor,
            ),
          ];
        },
        // list of images for scrolling
        body: Stack(
          children: [
            Container(
              //padding: const EdgeInsets.only(top: 72),
              //color: Colors.transparent,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 20, left: 20, top: 10),
                      children: [
                        for (Pharmacy Pharm in _foundPharmacy.reversed)
                          PharmacyItem(
                            pharm: Pharm,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Pharmacy> results = [];
    if (enteredKeyword.isEmpty) {
      results = pharmacyList;
    } else {
      results = pharmacyList
          .where((item) =>
              item.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundPharmacy = results;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(
          color: AppColors.backGround,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(-6, -5), // Shadow position
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(6, 5), // Shadow position
            ),
          ],
        ),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      centerTitle: true,
      title: const Text("Searsh for branch"),
    );
  }
}

class Card {
  final Image img;
  final String title;

  const Card({
    required this.img,
    required this.title,
  });
}
