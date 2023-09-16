import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../widgets/pharmacy_card.dart';
import '../constants/app_colors.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pharmacyList = Pharmacy.pharmacyList();
  List<Pharmacy> _foundPharmacy = [];
  final _todoController = TextEditingController();
  Image image = Image.asset(AppImages.profileIcon);
  List<Card> cards = [
    Card(img: Image.asset(AppImages.mvrk), title: "donate"),
    Card(img: Image.asset(AppImages.mvrk), title: "donate"),
    Card(img: Image.asset(AppImages.mvrk), title: "donate"),
  ];

  @override
  void initState() {
    _foundPharmacy = pharmacyList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            // padding: const EdgeInsets.symmetric(
            //   horizontal: 20,
            //   vertical: 15,
            // ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Donation ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: "(3)", //"(${_foundPharmacy.length})",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 96,
                        child: ListView.separated(
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 0,
                            );
                          },
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return buildCard(card: cards[index]);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Nearby Branch ',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                        /*defining default style is optional */
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "(${_foundPharmacy.length})",
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                // height: 40,
                                // width: 40,
                                child: const Text("See all",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ]),
                      ),
                      for (Pharmacy Pharm in _foundPharmacy.reversed)
                        PharmacyItem(
                          name: Pharm.name,
                          location: Pharm.location,
                          time: Pharm.time,
                          distance: Pharm.distance,
                          // onToDoChanged: _handleToDoChange,
                          // onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
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

  Widget buildCard({required Card card}) => Container(
        width: 100,
        //height: 200,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                // width: 50,
                // height: 50,
                child: card.img,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(card.title),
          ],
        ),
      );

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(
            Icons.location_on_rounded,
            color: Colors.black,
            size: 30,
          ),
          const Text("Location"),
          Transform.rotate(
            angle: 270 * math.pi / 180,
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded)),
          ),
        ]),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ]),
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
