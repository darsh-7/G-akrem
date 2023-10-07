import 'package:akrem/Screens/main/show_pharm.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/fake_api.dart';
import '../constants/app_images.dart';

class PharmacyItem extends StatelessWidget {
  final Pharmacy pharm;

  const PharmacyItem({
    Key? key,
    required this.pharm,
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
            blurRadius: 5,
            offset: const Offset(0, -1), // Shadow position
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 8), // Shadow position
          ),
        ],
      ),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowPharm(
                    pharm: pharm,
                  )),
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: const EdgeInsets.all(0),
        //const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        tileColor: Colors.transparent,
        // leading: Icon(
        //   todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        //   color: tdBlue,
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: <Widget>[
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  // borderRadius: const BorderRadius.all(Radius.elliptical(30, 50)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(20.0)),
                  //const BorderRadius.all(Radius.circular(20.0)),
                  child:
                  FadeInImage(
                    image:NetworkImage(pharm.img),
                    placeholder: const AssetImage(AppImages.noImage),
                    imageErrorBuilder:(context, error, stackTrace) {
                      return Image.asset(AppImages.noImage,
                          fit: BoxFit.fitWidth
                      );
                    },
                    fit: BoxFit.fitWidth,
                  ),
                  // CachedNetworkImage(
                  //   imageUrl:pharm.img,
                  //   placeholder: (context, url) => CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // ),

                  // FadeInImage(image: NetworkImage(pharm.img), placeholder: AssetImage(AppImages.noImage),
                  //     width: 400,
                  //     height: 230,
                  //     fit: BoxFit.fitWidth,
                  // ),

                ),
              ),
              Container(
                  height: 108,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 170),
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
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
                            (pharm.name ?? ""),
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
                                  text: '${pharm.locName}',
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
                                  text: '${pharm.time} min ',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  /*defining default style is optional */
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: "• no EX km",
                                        style: TextStyle(color: Colors.black)),
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

      ),
    );
  }
}
