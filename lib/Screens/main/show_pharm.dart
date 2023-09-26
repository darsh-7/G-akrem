import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../../constants/medic.dart';
import '../../widgets/medic_card.dart';
import '../../constants/app_colors.dart';
import 'dart:math' as math;
import 'package:percent_indicator/percent_indicator.dart';

class ShowPharm extends StatelessWidget {
  final Pharmacy pharm;
   ShowPharm({
    Key? key,
    required this.pharm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black54.withOpacity(0.8),
                    ),
                    child: const BackButtonIcon()),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backGround,
      //appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28,
            width: double.infinity,
            color: AppColors.mainColor,
          ),

          Stack(children: <Widget>[
            ClipRRect(
              child: Image.asset(
                pharm.img,
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
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 30, left: 16.0, right: 12.0),
                        child: Text(
                          ("name"),
                          style: TextStyle(
                            fontSize: 20,
                            color: tdBlack,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,

                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ]),
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
                      text: 'locName',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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
                      text: 'time min ',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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

          Divider(
            indent: 15,
            endIndent: 15,
            thickness: 1.2,
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 13.0,
                  animation: false,
                  percent: 0.7,
                  center: const Text(
                    "70.0%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: const Text(
                    "Box Storage",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        overflow: TextOverflow.clip),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
