import 'dart:io';

import 'package:akrem/constants/app_images.dart';
import 'package:akrem/controller/basket_controller.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../services/validator.dart';

class AddMedic extends StatefulWidget {
  const AddMedic({super.key});

  @override
  State<AddMedic> createState() => _AddMedicState();
}

class _AddMedicState extends State<AddMedic> {
  BasketController controller = Get.find();
  Uint8List pic = Get.arguments["picFile"];
  String text = Get.arguments["text"];
  String medicName = Get.arguments["medicName"];
  String medicConcentration = Get.arguments["medicConcentration"];
  String medicTablets = Get.arguments["medicTablets"];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ConcentrationController = TextEditingController();

  final _barController = TextEditingController();
  final _pillController = TextEditingController();
  final _dateController = TextEditingController();

  Duration minExDate = const Duration(days: 3 * 7);
  late DateTime selectedDate;

  var _selectedIndex = 1;

  final List<Card> cards = [
    Card(
        id: 1,
        img: Image.asset(AppImages.mvrk),
        title: "Box",
        action: 1,
        trigger: true,
        onPreess: () {
          //  onSelectCard(1);
        }),
    Card(
        id: 2,
        img: SvgPicture.asset(AppImages.pillIcon),
        title: "Bar",
        action: 2,
        trigger: false),
    Card(
        id: 3,
        img: Image.asset(AppImages.mvrk),
        title: "Liquid",
        action: 3,
        trigger: false),
    Card(
        id: 4,
        img: Image.asset(AppImages.mvrk),
        title: "device",
        action: 4,
        trigger: false),
    Card(
        id: 5,
        img: Image.asset(AppImages.mvrk),
        title: "Injections",
        action: 5,
        trigger: false),
    Card(
        id: 6,
        img: Image.asset(AppImages.mvrk),
        title: "Drops",
        action: 6,
        trigger: false),
    Card(
        id: 7,
        img: Image.asset(AppImages.mvrk),
        title: "Inhalers",
        action: 7,
        trigger: false),
    Card(
        id: 8,
        img: Image.asset(AppImages.mvrk),
        title: "patches",
        action: 8,
        trigger: false),
    Card(
        id: 9,
        img: Image.asset(AppImages.mvrk),
        title: "Suppositories",
        action: 9,
        trigger: false),
  ];

  Future<void>? onSelectCard(int i) {
    return null;

    // cards.forEach((element) {
    //   element.trigger = false;
    // });
  }

  String plusOne(String num) {
    if (num.isEmpty) return "1";
    return (int.parse(num) + 1).toString();
  }

  String minusOne(String num) {
    if (num.isEmpty) return "0";
    return (int.parse(num) - 1).toString();
  }

  @override
  void initState() {
    print("text: $text");
    super.initState();
    print("///// text : $text , medicName : $medicName , medicNum : $medicConcentration");
    String val = "$medicName";
    print("heall ($medicName)");
    _nameController.text = val.trim().replaceAll(RegExp(r'(\n){3,}'), "\n\n");
    _ConcentrationController.text = medicConcentration.trim().replaceAll(RegExp(r'(\n){3,}'), "\n\n");
    _pillController.text = medicTablets.trim().replaceAll(RegExp(r'(\n){3,}'), "\n\n");
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          //Padding(padding: EdgeInsets.only(top: statusBarHeight), child: null),
          Container(
            height: 250,
            width: double.infinity,
            padding: const EdgeInsets.only(
              bottom: 12,
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
                    child: Image.memory(
                  pic,
                  width: 400,
                  height: 300,
                  fit: BoxFit.fill,
                )),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            // this is the start of example
            child: Wrap(
              children: List.generate(cards.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 4),
                  child: RawChip(
                      padding: EdgeInsets.all(0),
                      labelPadding: EdgeInsets.all(0),
                      labelStyle: _selectedIndex == cards[index].id
                          ? TextStyle(color: Colors.white)
                          : TextStyle(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      showCheckmark: false,
                      label: Container(
                        width: 100,
                        height: 80,
                        margin: const EdgeInsets.only(left: 4, right: 4),
                        child: Column(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1 / 1,
                                child: SizedBox(
                                  // width: 40,
                                  // height: 40,
                                  child: cards[index].img,
                                ),
                              ),
                            ),
                            SizedBox(
                              // height: 14,
                              // width: 70,
                              child: Text(
                                cards[index].title,
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
                      elevation: 0,
                      pressElevation: 0,
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.white60,
                      selected: (_selectedIndex == 0)
                          ? (cards[index].id == 1 ? true : false)
                          : _selectedIndex == cards[index].id,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedIndex = cards[index].id;
                        });
                      }),
                );
              }),
              spacing: 8,
            ),
          ),
          // SizedBox(
          //   height: 100,
          //   child: ListView.separated(
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  CustomInputField(
                    hintText: "Name",
                    controller: _nameController,
                    validator: Validator.validateEmpty,
                    label: "Name",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    keyboardType: TextInputType.number,
                    hintText: "Concentration Concentration ",
                    controller: _ConcentrationController,
                    validator: Validator.validateEmpty,
                    label: "Concentration ",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                  ),
                  (_selectedIndex == 1 || _selectedIndex == 2)
                      ? Container(
                          margin: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
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
                                        text: const TextSpan(
                                          text: 'No.bars',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                          /*defining default style is optional */
                                          children: <TextSpan>[
                                            // TextSpan(
                                            //     text: "*",
                                            //     style: TextStyle(color: Colors.red)),
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
                                            onPressed: () => _barController
                                                    .text =
                                                plusOne(_barController.text),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 60,
                                        margin: const EdgeInsets.only(
                                            top: 20,
                                            right: 20,
                                            left: 20,
                                            bottom: 10),
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
                                            onPressed: () => _barController
                                                    .text =
                                                plusOne(_barController.text),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                        )
                      : Container(
                          margin: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
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
                                        text: const TextSpan(
                                          text: 'Quantity',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                          /*defining default style is optional */
                                          children: <TextSpan>[
                                            // TextSpan(
                                            //     text: "*",
                                            //     style: TextStyle(color: Colors.red)),
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
                                            onPressed: () => _barController
                                                    .text =
                                                plusOne(_barController.text),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 60,
                                        margin: const EdgeInsets.only(
                                            top: 20,
                                            right: 20,
                                            left: 20,
                                            bottom: 10),
                                        //padding: EdgeInsets.all(0),
                                        child: CustomInputField(
                                          keyboardType: TextInputType.number,
                                          //hintText: "bars",
                                          controller: _barController,
                                          validator: Validator.validateEmpty,
                                          // label: "bars",
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
                                            onPressed: () => _barController
                                                    .text =
                                                plusOne(_barController.text),
                                          ),
                                        ),
                                      )
                                    ]),
                              ]),
                        ),
                  if (_selectedIndex == 1 || _selectedIndex == 2)
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
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
                                        top: 20,
                                        right: 20,
                                        left: 20,
                                        bottom: 10),
                                    //padding: EdgeInsets.all(0),
                                    child: CustomInputField(
                                      keyboardType: TextInputType.number,
                                      hintText: "pills",
                                      controller: _pillController,
                                      //  validator: Validator.validateEmpty,
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
                  if (_selectedIndex != 4)
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
                          width: MediaQuery.of(context).size.width - 40,
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
                      ],
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            width: 1.0, color: Get.theme.shadowColor),
                        color: Colors.red.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(-8, 8), // Shadow position
                          ),
                          BoxShadow(
                            color: Colors.red.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(8, 8), // Shadow position
                          ),
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Please check our terms for accepting donations',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Get.theme.shadowColor),
                              /*defining default style is optional */
                              children: <TextSpan>[
                                // TextSpan(
                                //     text: "\nclick to know our terms",
                                //     style: TextStyle(
                                //         color: AppColors.mainColor)),
                                // TextSpan(
                                //   text: " ",
                                //   //style: TextStyle(color: Colors.red)
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.info_outline,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
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
      backgroundColor: Get.theme.primaryColor.withOpacity(0.5),
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
                        Get.close(1);
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
        card.onPreess();
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
  final id;

  final Widget img;
  final String title;
  final int? action;
  bool trigger;
  final onPreess;

  Card({
    required this.id,
    required this.img,
    required this.title,
    this.action,
    this.trigger = false,
    this.onPreess,
  });
}
