import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PharmacyItem extends StatelessWidget {
  final String img;
  final String? name;
  final String? locName;

  // final String? location;
  final int? time;

  // final int? boxStorage;
  // final String? phone;

  const PharmacyItem({
    Key? key,
    required this.img,
    required this.name,
    required this.locName,
    //required this.location,
    required this.time,
    //required this.boxStorage,
    //required this.phone,
    // required this.onToDoChanged,
    // required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
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
                                      text: ": ${locName}",
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
                              text: const TextSpan(
                                text: 'Distance ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                /*defining default style is optional */
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ": ${"NOT EX"} km",
                                      style:
                                          TextStyle(color: Colors.black)),
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
        },
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
                // borderRadius: const BorderRadius.all(Radius.elliptical(30, 50)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(20.0)),
                //const BorderRadius.all(Radius.circular(20.0)),
                child: Image.asset(

                  img,
                  width: 400,
                  height: 230,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                  height: 100,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: AppColors.mainColor,
                                size: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '$locName',
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
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
                                    const TextSpan(
                                        text: "• no EX km",
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ],
                  )),
            ]),
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
