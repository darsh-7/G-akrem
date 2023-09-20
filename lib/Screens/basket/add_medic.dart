import 'package:akrem/constants/app_images.dart';
import 'package:akrem/widgets/input.dart';
import 'package:akrem/widgets/medic_item.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/medic.dart';
import 'dart:math' as math;

import '../show_branchs.dart';

class AddMedic extends StatelessWidget {
  AddMedic({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<Card> cards = [
    Card(
        img: Image.asset(AppImages.mvrk), title: "Box", action: 1),
    Card(img: Image.asset(AppImages.mvrk), title: "Bar", action: 2),
    Card(img: Image.asset(AppImages.mvrk), title: "medicine bottle", action: 3),
    Card(
        img: Image.asset(AppImages.mvrk),
        title: "Medical device",
        action: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            //padding: const EdgeInsets.only(bottom: 100),

            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: AppColors.mainColor,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 0,
                      bottom: 10,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Image.asset(AppImages.pharmacy),
                    )
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 80, top: 10),
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
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 20,
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
                                              text: "(7)",
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Container(
                                // height: 40,
                                // width: 40,
                                child: TextButton(
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowBranch()),
                                        )),
                              ),
                            ]),
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
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text("New donation"),
        ]),
        Container(
          height: 40,
          width: 120,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: IconButton(
                icon: const Icon(Icons.fiber_smart_record),
                onPressed: () => {
                  //TODO : add voice recognition for adding items
                },
              )),
        ),
      ]),
    );
  }
}

Widget buildCard({required Card card}) => Container(
  width: 100,
  //height: 200,

  child: ListTile(
    onTap: () {
      switch (card.action) {
        case 1:
          {

          }
          break;

        case 2:
          {
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

  const Card({
    required this.img,
    required this.title,
    this.action,
  });
}

