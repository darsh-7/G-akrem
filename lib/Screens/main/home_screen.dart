import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/show_branchs.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/pharmacy_card.dart';
import '../../constants/app_colors.dart';
import 'dart:math' as math;
import 'dart:io';

class Home extends StatefulWidget {
  final List<CameraDescription> cameraDescription;

  Home({
    required this.cameraDescription,
    super.key,
  });

  @override
  State<Home> createState() => _HomeState(cameraDescription: cameraDescription);
}

class _HomeState extends State<Home> {
  late List<CameraDescription> cameraDescription;

  _HomeState({
    required this.cameraDescription,
  });

  final pharmacyList = Pharmacy.pharmacyList;
  List<Pharmacy> _foundPharmacy = [];
  Image image = Image.asset(AppImages.profileIcon);
  bool loddingBar = true;

  final List<Card> cards = [
    Card(
        img: SvgPicture.asset(AppImages.donateFromHome),
        title: "Donate from home",
        action: 1),
    Card(
        img: Container(
            margin: EdgeInsets.all(8),
            child: SvgPicture.asset(
              AppImages.nearesBransh,
            )),
        title: "Nearest branch",
        action: 2),
    Card(
        img: Container(
            margin: EdgeInsets.all(8),
            child: SvgPicture.asset(AppImages.donateBoxIcon)),
        title: "Donate to box",
        action: 3),
    Card(
        img: SvgPicture.asset(AppImages.fastDonation),
        title: "Fast Donation order",
        action: 4),
    Card(
        img: Container(
            margin: EdgeInsets.all(8),
            child: SvgPicture.asset(AppImages.donate)),
        title: "Support US",
        action: 5),
  ];

  @override
  void initState() {
    _foundPharmacy = pharmacyList;
    _getThingsOnStartup().then((value) {
      print('Async done');
    });
    super.initState();
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      loddingBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () => {
                              SystemNavigator.pop(),
                            },
                        child: const Text(
                          "NO",
                          style: TextStyle(color: AppColors.positives),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Leave",
                            style: TextStyle(color: AppColors.negative)))
                  ],
                  title: const Text("want to leave? "),
                  content: const Text(
                      "Are you sure you want to leave the app? \n if yse click leave other with click no"),
                ));
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Column(
              children: [
                Visibility(
                  visible: loddingBar,
                  child: const LinearProgressIndicator(
                    minHeight: 8,
                  ),
                ),
                //searchBox(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 80, top: 10),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 0,
                          bottom: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
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
                                  text: "(5)",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
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
                              TextButton(
                                  child: const Text(
                                    "See all",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowBranch()),
                                      )),
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

  Widget buildCard({required Card card}) => SizedBox(
        width: 100,
        //height: 200,
        child: ListTile(
          onTap: () {
            switch (card.action) {
              case 1:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicList(
                              cameraDescription: cameraDescription,
                            )),
                  );
                }
                break;

              case 2:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowBranch()),
                  );
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
                                    Navigator.of(context).pop();
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
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(
            Icons.location_on_rounded,
            color: Colors.deepOrange,
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
              Icons.notifications,
              color: Colors.black54,
              size: 30,
            ),
          ),
        ),
      ]),
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
