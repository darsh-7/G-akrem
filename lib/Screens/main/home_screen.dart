import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/customer_screen/Home/basket_page.dart';
import 'package:akrem/Screens/main/show_branchs.dart';
import 'package:akrem/Screens/map/Select_location.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/constants/app_local.dart';
import 'package:akrem/controller/basket_controller.dart';
import 'package:akrem/controller/shopping_card_controller.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/widgets/skeleton.dart';
import 'package:akrem/widgets/statistics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/pharmacy_card.dart';
import '../../constants/app_colors.dart';
import 'dart:math' as math;

import '../../widgets/upcoming_order.dart';
import 'NavigationBar.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // UserController userController = Get.find();

  final pharmacyList = Pharmacy.pharmacyList;
  List<Pharmacy> _foundPharmacy = [];
  Image image = Image.asset(AppImages.profileIcon);
  var _isLoading = true.obs;
  List<Card> cards = [];
  final ShoppingCardController shoppingCardController = Get.find();
  final BasketController basketController = Get.put(BasketController());

  @override
  void initState() {
    _foundPharmacy = pharmacyList;
    _getThingsOnStartup().then((value) {
      // print('Async done');
    });
    print(" token val :${(userController.user).token}");
    print("locationString val :${(userController.user).locationString}");
    print(" name val :${(userController.user).fName}");
    print(" email val :${(userController.user).email}");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cards = [
        Card(
            img: SvgPicture.asset(AppImages.donateFromHome),
            title: getLang(context, "Donate from home"),
            action: 1),
        Card(
            img: Container(
                margin: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  AppImages.akremLogoSVG,
                  colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                )),
            title: getLang(context, "Consume"),
            action: 2),
        // Card(
        //     img: Container(
        //         margin: const EdgeInsets.all(8),
        //         child: SvgPicture.asset(
        //           AppImages.nearesBransh,
        //         )),
        //     title: getLang(context, "Nearest branch"),
        //     action: 2),
        Card(
            img: Container(
                margin: const EdgeInsets.all(8),
                child: SvgPicture.asset(AppImages.donateBoxIcon)),
            title: getLang(context, "Donate to box"),
            action: 3),
        Card(
            img: Container(
                margin: const EdgeInsets.all(8),
                child: SvgPicture.asset(AppImages.donate)),
            title: getLang(context, "Support US"),
            action: 4),
        // Card(
        //     img: SvgPicture.asset(AppImages.fastDonation),
        //     title: "Fast Donation order",
        //     action: 5),
      ];
    });
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(seconds: 1));
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Obx(
                () =>
                Column(
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
                              child: Text(
                                getLang(context, "Upcoming Order"),
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
                            child: Row(children: [
                              Text(
                                getLang(context, "Donation Options"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Text(
                              //   '(5)',
                              //   style: TextStyle(
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.w500,
                              //     color: Colors.deepOrange,
                              //   ),
                              // ),
                            ]),
                          ),
                          SizedBox(
                              height: 210,
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Expanded(
                                          child: SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 2.1,
                                            child: Stack(
                                              children: [
                                                buildCard(card: cards[0]),
                                                GetBuilder<ShoppingCardController>(builder: (_) {
                                                  if (basketController.medics.length == 0) {
                                                    return SizedBox();
                                                  } else
                                                    return Positioned(
                                                      right:  MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 7.5,
                                                      bottom: 32,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                        constraints: BoxConstraints(
                                                          minWidth: 28,
                                                          minHeight: 28,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            basketController.medics.length.toString(),
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                }),
                                              ],
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 2.1,
                                            child: Stack(
                                              children: [
                                                buildCard(card: cards[1]),
                                                GetBuilder<ShoppingCardController>(builder: (_) {
                                                  if (shoppingCardController.cart.length == 0) {
                                                    return SizedBox();
                                                  } else
                                                    return Positioned(
                                                      right:  MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 7.5,
                                                      bottom: 32,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                        constraints: BoxConstraints(
                                                          minWidth: 28,
                                                          minHeight: 28,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            shoppingCardController.cart.length.toString(),
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                }),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Expanded(
                                          child: buildCard(card: cards[2])
                                      ),
                                      Expanded(
                                          child: buildCard(card: cards[3])
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          //   ListView.separated(
                          //     // This next line does the trick.
                          //     scrollDirection: Axis.horizontal,
                          //     separatorBuilder: (context, index) {
                          //       return const SizedBox(
                          //         width: 0,
                          //       );
                          //     },
                          //     itemCount: cards.length,
                          //     itemBuilder: (context, index) {
                          //       return buildCard(card: cards[index]);
                          //     },
                          //   ),
                          // ),
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
                                          Text(
                                            getLang(context, "Nearest branch"),
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
                                      child: Text(
                                        getLang(context, "See all"),
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

  Widget buildCard({required Card card}) =>
      SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width / 2.1,
        //height: 200,
        child: InkWell(
          onTap: () {
            switch (card.action) {
              case 1:
                {
                  Get.to(MedicList());
                }
                break;

              case 2:
                {
                  // Get.to(ShowBranch());
                  Get.to(BasketPage());
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
                      builder: (context) =>
                          AlertDialog(
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
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 5.5,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: card.img,
                ),
              ),
              SizedBox(
                child: Text(
                  card.title,
                  //softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  //textWidthBasis: TextWidthBasis.values.last,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
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
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
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
            hintText: getLang(context, "Search"),
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
      title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Icon(
          Icons.location_on_rounded,
          color: Colors.deepOrange,
          size: 30,
        ),
        GetBuilder<UserController>(builder: (_) {
          print("location string ${userController.user.locationString}");
          return GestureDetector(
            child: Row(
              children: [
                SizedBox(
                  width: Get.mediaQuery.size.width - 200,
                  child: Text(
                    userController.user.locationString ?? "No Location",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Transform.rotate(
                    angle: 270 * math.pi / 180,
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.23),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ))),
              ],
            ),
            onTap: () {
              Get.offAll(() => SelectLocation());
            },
          );
        }),
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
