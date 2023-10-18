import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/main/show_branchs.dart';
import 'package:akrem/Screens/map/map_screen.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/db/user_preference.dart';
import 'package:akrem/model/user.dart';
import 'package:akrem/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/pharmacy_card.dart';
import '../../constants/app_colors.dart';
import 'dart:math' as math;

import '../../widgets/upcoming_order.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  UserController userController = Get.find();
  User get _userController {
    return userController.user;
  }
  final pharmacyList = Pharmacy.pharmacyList;
  List<Pharmacy> _foundPharmacy = [];
  Image image = Image.asset(AppImages.profileIcon);
  var _isLoading = true.obs;
  final List<Card> cards = [
    Card(
        img: SvgPicture.asset(AppImages.donateFromHome),
        title: "Donate from home",
        action: 1),
    Card(
        img: Container(
            margin: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              AppImages.nearesBransh,
            )),
        title: "Nearest branch",
        action: 2),
    Card(
        img: Container(
            margin: const EdgeInsets.all(8),
            child: SvgPicture.asset(AppImages.donateBoxIcon)),
        title: "Donate to box",
        action: 3),
    Card(
        img: Container(
            margin: const EdgeInsets.all(8),
            child: SvgPicture.asset(AppImages.donate)),
        title: "Support US",
        action: 4),
    Card(
        img: SvgPicture.asset(AppImages.fastDonation),
        title: "Fast Donation order",
        action: 5),
  ];

  @override
  void initState() {
    _foundPharmacy = pharmacyList;
    _getThingsOnStartup().then((value) {
      // print('Async done');
    });
    userController.getUser();
    super.initState();
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(seconds: 3));
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Obx(
            () => Column(
              children: [
                Visibility(
                  visible: _isLoading.value,
                  child: const LinearProgressIndicator(
                    minHeight: 8,
                  ),
                ),
                //searchBox(),
                Expanded(
                  child: _isLoading.value
                      ? ListView(
                          padding: const EdgeInsets.all(40),
                          children: [const SkeltonView()])
                      // ListView.separated(
                      //         itemCount: 5,
                      //         itemBuilder: (context, index) =>
                      //             const NewsCardSkelton(),
                      //         separatorBuilder: (context, index) =>
                      //             const SizedBox(height: 16),
                      //       )
                      : ListView(
                          padding: const EdgeInsets.only(bottom: 80, top: 10),
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                  top: 0,
                                  bottom: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                child: const Text(
                                  'Upcoming Order ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 0,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: const UpcomingCard(),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 0,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: const Row(children: [
                                Text(
                                  'Donation Servers ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '(5)',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 108,
                              child: ListView.separated(
                                // This next line does the trick.
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 0,
                                  );
                                },
                                itemCount: cards.length,
                                itemBuilder: (context, index) {
                                  return buildCard(card: cards[index]);
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            const Text(
                                              'Nearby Branch ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '(${_foundPharmacy.length})',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          ]),
                                        ]),
                                    TextButton(
                                        child: const Text(
                                          "See all",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () =>
                                            Get.to(() => ShowBranch())),
                                  ]),
                            ),
                            for (Pharmacy Pharm in _foundPharmacy.reversed)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 20),
                                child: PharmacyItem(
                                  pharm: Pharm,
                                ),
                              )
                          ],
                        ),
                )
              ],
            ),
          )
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

  Widget buildCard({required Card card}) => SizedBox(
        width: 100,
        //height: 200,
        child: ListTile(
          onTap: () {
            switch (card.action) {
              case 1:
                {
                  Get.to(MedicList());
                }
                break;

              case 2:
                {
                  Get.to(ShowBranch());
                }
                break;

              // case 3: {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ShowBranch()),
              //TODO:donat to the box
              //   );
              // }
              // break;

              // case 4: {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ShowBranch()),
              //TODO:Fast donation
              //   );
              // }
              // break;

              default:
                {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Close"))
                            ],
                            title: const Text("Error"),
                            content: const Text(
                                "Sorry this button not working \n try again later"),
                          ));
                }
                break;
            }
          },
          title: Column(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  // width: 50,
                  // height: 50,
                  child: card.img,
                ),
              ),
              SizedBox(
                height: 14,
                width: 70,
                child: Text(
                  card.title,
                  //softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  //textWidthBasis: TextWidthBasis.values.last,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      );

  Widget searchBox() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.mainColor,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        // padding: const EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
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
              color: tdBlack,
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
      backgroundColor: Get.theme.appBarTheme.backgroundColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(
            Icons.location_on_rounded,
            color: Colors.deepOrange,
            size: 30,
          ),
        GetBuilder<UserController>(builder: (_) {
          print("location string ${_userController.locationString}");
          return
          SizedBox(
            width: Get.mediaQuery.size.width-200,
            child:
              Text(
                _userController.locationString ?? "Location",
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
          );
        }),
          Transform.rotate(
              angle: 270 * math.pi / 180,
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.23),
                  ),
                  child: SizedBox(
                    width: 100,
                    child: IconButton(
                        padding: EdgeInsets.only(top: 8, right: 8, left: 0),
                        onPressed: () => Get.offAll(SelectLocation()),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        )),
                  ))),
        ]),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black54,
                  size: 30,
                ),
                onPressed: () => {
                      // setState(() {
                      //   _isLoading = !_isLoading;
                      // })
                    }),
          ),
        ),
      ]),
    );
  }
}

class SkeltonView extends StatelessWidget {
  const SkeltonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(height: 24, width: 120),
        SizedBox(
          height: 12,
        ),
        Skeleton(height: 124, width: double.infinity),
        SizedBox(
          height: 12,
        ),
        Skeleton(height: 24, width: 120),
        SizedBox(
          height: 12,
        ),
        Skeleton(height: 70, width: double.infinity),
        SizedBox(
          height: 12,
        ),
        Skeleton(height: 24, width: 120),
        SizedBox(
          height: 12,
        ),
        Skeleton(height: 260, width: double.infinity),
        SizedBox(
          height: 12,
        ),
        Skeleton(height: 260, width: double.infinity),
      ],
    );
  }
}

class Card {
  final Widget img;
  final String title;
  final int? action;

  const Card({
    required this.img,
    required this.title,
    this.action,
  });
}
