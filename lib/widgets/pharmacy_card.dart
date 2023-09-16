import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PharmacyItem extends StatelessWidget {
  final String? name;
  final String? location;
  final int? time;
  final String? distance;

  // final onToDoChanged;
  // final onDeleteItem;

  const PharmacyItem({
    Key? key,
    required this.name,
    required this.location,
    required this.time,
    required this.distance,
    // required this.onToDoChanged,
    // required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext builder) {
              return CupertinoPopupSurface(
                child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 400,
                    child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name ',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ": ${name}",
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Location ',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ": ${location}",
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Time ',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ": ${time}",
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Distance ',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ": ${distance} km",
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/Pharmacy.png",
                              scale: 1,
                            ),
                          ],
                        ))),
              );
            },
          );

          // print('Clicked on Todo Item.');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        tileColor: Colors.white,
        // leading: Icon(
        //   todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        //   color: tdBlue,
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.pharmacy,
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 1.0),
              child: Text(
                (name ?? ""),
                style: const TextStyle(
                  fontSize: 16,
                  color: tdBlack,
                ),
              ),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              thickness: 1.2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 1.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.location_on_rounded,
                  color: AppColors.mainColor,
                  size: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: '$location ',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      // TextSpan(
                      //     text:
                      //     "($distance km)",
                      //     style: const TextStyle(
                      //         color: Colors.red)),
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 1.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.timer,
                  color: AppColors.mainColor,
                  size: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: '$time min ',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text: "• $distance km",
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),

        // trailing: Container(
        //   padding: const EdgeInsets.all(0),
        //   margin: const EdgeInsets.symmetric(vertical: 12),
        //   height: 35,
        //   width: 35,
        //   decoration: BoxDecoration(
        //     color: tdRed,
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: IconButton(
        //     color: Colors.white,
        //     iconSize: 18,
        //     icon: const Icon(Icons.delete),
        //     onPressed: () {
        //       // print('Clicked on delete icon');
        //       //onDeleteItem(todo.id);
        //     },
        //   ),
        // ),
      ),
    );
  }
}
