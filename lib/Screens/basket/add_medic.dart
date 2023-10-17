import 'dart:io';

import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/basket_controller.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/model/medic.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../services/log_manager.dart';
import '../../services/validator.dart';

class AddMedic extends StatelessWidget {
  AddMedic({super.key});

  BasketController controller = Get.find();
  Uint8List pic = Get.arguments["picFile"];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _barController = TextEditingController();
  final _pillController = TextEditingController();
  final _dateController = TextEditingController();

  Duration minExDate = const Duration(days: 3 * 7);
  late DateTime selectedDate;

  final List<Card> cards = [
    Card(
        img: Image.asset(AppImages.mvrk),
        title: "Box",
        action: 1,
        trigger: true),
    Card(
        img: SvgPicture.asset(AppImages.pillIcon),
        title: "Bar",
        action: 2,
        trigger: false),
    Card(
        img: Image.asset(AppImages.mvrk),
        title: "medicine bottle",
        action: 3,
        trigger: false),
    Card(
        img: Image.asset(AppImages.mvrk),
        title: "Medical device",
        action: 4,
        trigger: false),
  ];

  String plusOne(String num) {
    if (num.isEmpty) return "1";
    return (int.parse(_pillController.text) + 1).toString();
  }

  String minusOne(String num) {
    if (num.isEmpty) return "0";
    return (int.parse(_pillController.text) - 1).toString();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.only(top: statusBarHeight), child: null),
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: Colors.transparent,
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.transparent,
              ),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                    // borderRadius: const BorderRadius.all(Radius.elliptical(30, 50)),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(20.0)),
                    //const BorderRadius.all(Radius.circular(20.0)),
                    child: Image.memory(
                      pic,
                      width: 400,
                      height: 300,
                      fit: BoxFit.fill,
                    )),
              ),

              // ClipRRect(
              //   borderRadius:
              //   const BorderRadius.all(Radius.elliptical(30, 50)),
              //   child: Image.asset(
              //     AppImages.pharmacy,
              //     width: 400,
              //     height: 300,
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),
          ),
          SizedBox(
            height: 100,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  CustomInputField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Name",
                    controller: _nameController,
                    validator: Validator.validateEmpty,
                    label: "Name",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'No.bars',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                    /*defining default style is optional */
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "*",
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 60,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: AppColors.negative,
                                    child: TextButton(
                                      child: Icon(
                                        Icons.exposure_plus_1,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _barController.text =
                                          plusOne(_barController.text),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 60,
                                  margin: const EdgeInsets.only(
                                      top: 20, right: 20, left: 20, bottom: 10),
                                  //padding: EdgeInsets.all(0),
                                  child: CustomInputField(
                                    keyboardType: TextInputType.number,
                                    hintText: "bars",
                                    controller: _barController,
                                    validator: Validator.validateEmpty,
                                    label: "bars",
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: AppColors.positives,
                                    child: TextButton(
                                      child: Icon(
                                        Icons.exposure_plus_1,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _barController.text =
                                          plusOne(_barController.text),
                                    ),
                                  ),
                                )
                              ]),
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'No.pills',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                    /*defining default style is optional */
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "\n(Optional)",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 60,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: AppColors.negative,
                                    child: TextButton(
                                      child: Icon(
                                        Icons.exposure_minus_1,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _pillController.text =
                                          minusOne(_pillController.text),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 60,
                                  margin: const EdgeInsets.only(
                                      top: 20, right: 20, left: 20, bottom: 10),
                                  //padding: EdgeInsets.all(0),
                                  child: CustomInputField(
                                    keyboardType: TextInputType.number,
                                    hintText: "pills",
                                    controller: _pillController,
                                    validator: Validator.validateEmpty,
                                    label: "pills",
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: AppColors.positives,
                                    child: TextButton(
                                      child: Icon(
                                        Icons.exposure_plus_1,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => _pillController.text =
                                          plusOne(_pillController.text),
                                    ),
                                  ),
                                )
                              ]),
                        ]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CustomInputField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Expiration date",
                        controller: _dateController,
                        label: "Expiration date",
                        readOnly: true,
                        validator: Validator.validateEmpty,
                        icon: const Icon(Icons.calendar_today),
                        width: 300,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100));

                          if (newDate == null) return;
                          selectedDate = newDate;

                          _dateController.text =
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        },
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(
                              left: 8),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Get.theme.primaryColor,
                          child: TextButton(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: () => {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == false) return;

                        if (selectedDate
                            .isAfter(DateTime.now().add(minExDate))) {
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
                                    title:
                                        const Text("Medicine about to expire"),
                                    content: const Text(
                                        "Sorry we cant take Medicine about to expire"),
                                  ));
                          return;
                        }
                        controller.addMedic(
                          img: pic,
                          name: _nameController.text,
                          bar: int.parse(_barController.text),
                          pills: int.parse(_pillController.text),
                          date: selectedDate,
                        );

                        Get.close(2);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("New medic Saved"),
                        ));
                        //Navigator.popUntil(context, ModalRoute.withName('/basket'));
                      },
                      child: const Text("Save")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Get.theme.primaryColor,
      ),
      elevation: 0,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black54.withOpacity(0.8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.close(3);
                      },
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildCard({required Card card}) {
  return Container(
    width: 100,
    //height: 200,
    margin: const EdgeInsets.only(left: 4, right: 4),
    decoration: const BoxDecoration(
      color: AppColors.mainColor,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: ListTile(
      onTap: () {
        switch (card.action) {
          case 1:
            {}
            break;

          case 2:
            {}
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

          // default:
          //   {
          //     showDialog(
          //         context: context,
          //         builder: (context) => AlertDialog(
          //           actions: [
          //             TextButton(
          //                 onPressed: () {
          //                   Navigator.of(context).pop();
          //                 },
          //                 child: const Text("Close"))
          //           ],
          //           title: const Text("Error"),
          //           content: const Text(
          //               "Sorry this button not working \n try again later"),
          //         ));
          //   }
          //   break;
        }
      },
      title: Column(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: SizedBox(
              width: 50,
              height: 50,
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
}

class Card {
  final Widget img;
  final String title;
  final int? action;
  final bool trigger;

  const Card({
    required this.img,
    required this.title,
    this.action,
    required this.trigger,
  });
}
