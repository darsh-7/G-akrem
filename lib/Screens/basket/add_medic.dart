import 'package:akrem/constants/app_images.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/medic.dart';
import 'package:flutter/services.dart';
import '../../services/log_manager.dart';
import '../../services/validator.dart';
import 'medic_list.dart';

class AddMedic extends StatefulWidget {
  AddMedic({Key? key}) : super(key: key);

  @override
  State<AddMedic> createState() => _AddMedic();
}

class _AddMedic extends State<AddMedic> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _barController = TextEditingController();
  final _pillController = TextEditingController();
  final _dateController = TextEditingController();
  late DateTime Date;

  Duration minExDate = const Duration(days: 3 * 7);
  DateTime selectedDate = DateTime.now();

  final List<Card> cards = [
    Card(
        img: Image.asset(AppImages.mvrk),
        title: "Box",
        action: 1,
        trigger: true),
    Card(
        img: Image.asset(AppImages.mvrk),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          LinearProgressIndicator(),
          Container(
            //padding: const EdgeInsets.only(bottom: 100),

            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: AppColors.mainColor,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 8,
                      right: 8,
                      left: 8,
                    ),
                    // padding:
                    //     const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(30, 50)),
                      child: Image.asset(
                        AppImages.pharmacy,
                        width: 400,
                        height: 300,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    children: [
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              CustomInputField(
                                keyboardType: TextInputType.emailAddress,
                                hintText: "Name",
                                controller: _nameController,
                                validator: Validator.validateName,
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
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ],
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 60,
                                              child: const CircleAvatar(
                                                radius: 100,
                                                backgroundColor:
                                                    AppColors.negative,
                                                child: Text(
                                                  '-',
                                                  style:
                                                      TextStyle(fontSize: 30),
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
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText: "bars",
                                                controller: _barController,
                                                validator:
                                                    Validator.validateName,
                                                label: "bars",
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      20),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              child: const CircleAvatar(
                                                radius: 100,
                                                backgroundColor:
                                                    AppColors.positives,
                                                child: Text(
                                                  '+',
                                                  style:
                                                      TextStyle(fontSize: 30),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 60,
                                              child: const CircleAvatar(
                                                radius: 100,
                                                backgroundColor:
                                                    AppColors.negative,
                                                child: Text(
                                                  '-',
                                                  style:
                                                      TextStyle(fontSize: 30),
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
                                                keyboardType:
                                                    TextInputType.number,
                                                hintText: "pills",
                                                controller: _pillController,
                                                //validator: Validator.validateName,
                                                label: "pills",
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      2),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              child: const CircleAvatar(
                                                radius: 100,
                                                backgroundColor:
                                                    AppColors.positives,
                                                child: Text(
                                                  '+',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ]),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: selectedDate,
                                                firstDate: DateTime(2020),
                                                lastDate: DateTime(2100));

                                        if (newDate == null) return;
                                        selectedDate = newDate;

                                        //Todo: Font asset "MaterialIcons-Regular.otf" was tree-shaken,
                                        // reducing it from 1645184 to 4716 bytes (99.7% reduction).
                                        // Tree-shaking can be disabled by providing the --no-tree-shake-icons flag when building your app.
                                        //
                                        // setState(() {
                                        //   selectedDate = newDate;
                                        //   debugPrint("new date :\t ${newDate.toString()}");
                                        // });
                                      },
                                      child: const Text("select date"),
                                    ),
                                    Text(
                                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                  onPressed: () {
                                    //if (_formKey.currentState?.validate() == false) return;

                                    if (selectedDate.isAfter(
                                        DateTime.now().add(minExDate))) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Close"))
                                                ],
                                                title: const Text(
                                                    "Medicine about to expire"),
                                                content: const Text(
                                                    "Sorry we cant take Medicine about to expire"),
                                              ));
                                      return;
                                    }

                                    Medic medic = Medic(
                                      img: Image.asset(AppImages.pharmacy),
                                      name: _nameController.text,
                                      bar: int.parse(_barController.text),
                                      pill: int.parse(_pillController.text),
                                      date: selectedDate,
                                    );
                                    MedicManager.addMedic(
                                      img: Image.asset(AppImages.pharmacy),
                                      name: _nameController.text,
                                      bar: int.parse(_barController.text),
                                      pills: int.parse(_pillController.text),
                                      date: selectedDate,
                                    );
                                    LogManager.logToConsole(
                                        "new Medic list now: ${MedicManager.medics.reversed}");

                                    //Navigator.of(context).pop(medic);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Save")),
                            ],
                          ),
                        ),
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      // title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //   const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      //     Text("New donation"),
      //   ]),
      //   Container(
      //     height: 40,
      //     width: 120,
      //     child: ClipRRect(
      //         borderRadius: BorderRadius.circular(20),
      //         child: IconButton(
      //           icon: const Icon(Icons.fiber_smart_record),
      //           onPressed: () => {
      //             //TODO : add voice recognition for adding items
      //           },
      //         )),
      //   ),
      // ]),
    );
  }
}

Widget buildCard({required Card card}) => Container(
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

class Card {
  final Image img;
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
