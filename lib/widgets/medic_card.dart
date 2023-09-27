import 'dart:io';

import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/constants/medic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicCard extends StatelessWidget {
  final File img;
  final String? name;
  final int? bar;
  final int? pill;
  final DateTime? date;
  final int index;
  final void Function(int) onDelete;


  const MedicCard({
    Key? key,
    required this.img,
    required this.name,
    this.bar,
    this.pill,
    this.date,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      Container(
        height: 310,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.transparent,
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
        child: ListTile(
          // onTap: () {
          //   showCupertinoModalPopup(
          //     context: context,
          //     builder: (BuildContext builder) {
          //       return CupertinoPopupSurface(
          //         child: Container(
          //             color: Colors.white,
          //             alignment: Alignment.center,
          //             width: double.infinity,
          //             height: 400,
          //             child: Container(
          //                 margin: const EdgeInsets.all(10.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.stretch,
          //                   children: [
          //                     RichText(
          //                       text: TextSpan(
          //                         text: 'Name ',
          //                         style: const TextStyle(
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.w500,
          //                             color: Colors.grey),
          //                         /*defining default style is optional */
          //                         children: <TextSpan>[
          //                           TextSpan(
          //                               text: ": ${name}",
          //                               style:
          //                               const TextStyle(color: Colors.black)),
          //                         ],
          //                       ),
          //                     ),
          //                     RichText(
          //                       text: TextSpan(
          //                         text: 'Location ',
          //                         style: const TextStyle(
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.w500,
          //                             color: Colors.grey),
          //                         /*defining default style is optional */
          //                         children: <TextSpan>[
          //                           TextSpan(
          //                               text: ": ${location}",
          //                               style:
          //                               const TextStyle(color: Colors.black)),
          //                         ],
          //                       ),
          //                     ),
          //                     RichText(
          //                       text: TextSpan(
          //                         text: 'Time ',
          //                         style: const TextStyle(
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.w500,
          //                             color: Colors.grey),
          //                         /*defining default style is optional */
          //                         children: <TextSpan>[
          //                           TextSpan(
          //                               text: ": ${time}",
          //                               style:
          //                               const TextStyle(color: Colors.black)),
          //                         ],
          //                       ),
          //                     ),
          //                     RichText(
          //                       text: TextSpan(
          //                         text: 'Distance ',
          //                         style: const TextStyle(
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.w500,
          //                             color: Colors.grey),
          //                         /*defining default style is optional */
          //                         children: <TextSpan>[
          //                           TextSpan(
          //                               text: ": ${distance} km",
          //                               style:
          //                               const TextStyle(color: Colors.black)),
          //                         ],
          //                       ),
          //                     ),
          //                     Image.asset(
          //                       "assets/Pharmacy.png",
          //                       scale: 1,
          //                     ),
          //                   ],
          //                 ))),
          //       );
          //     },
          //   );
          // },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: const EdgeInsets.all(0),
          //const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          tileColor: Colors.white,
          // leading: Icon(
          //   todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          //   color: tdBlue,
          // ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(20.0)),
                  //const BorderRadius.all(Radius.circular(20.0)),
                  child: Image.file(
                    img,
                    width: 400,
                    height: 230,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      //padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.close,size: 30,color: Colors.white,),
                        onPressed: () {
                          img.delete();
                          onDelete(index);
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  height: 126,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 180),
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 28,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 4.0, right: 1.0),
                          child: Text(
                            (name ?? ""),
                            style: const TextStyle(
                              fontSize: 16,
                              color: tdBlack,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'type : ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                  /*defining default style is optional */
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "( Why do you care :) )" ?? "_",
                                        style:
                                            TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 1.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'number of  bars : ',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                  /*defining default style is optional */
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "($bar)" ?? "_",
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 1.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Total number of  pills : ',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                  /*defining default style is optional */
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "($pill)",
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 1.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Expiration date : ',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                  /*defining default style is optional */
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "($date)" ?? "_",
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
