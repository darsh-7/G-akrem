import 'package:akrem/Api/fake_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../constants/app_images.dart';

late Color storageColor;

class ShowPharm extends StatelessWidget {
  final Pharmacy pharm;

  const ShowPharm({
    Key? key,
    required this.pharm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    if (pharm.boxStorage < 0.4) {
      storageColor = Colors.green;
    } else if (pharm.boxStorage < 0.7) {
      storageColor = Colors.orange;
    } else if (pharm.boxStorage < 1) {
      storageColor = Colors.red;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Get.theme.primaryColor,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.black54.withOpacity(0.8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () => Get.back(),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      //backgroundColor: AppColors.backGround,
      body: Stack(children: [
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(top: statusBarHeight), child: null),
            Stack(children: <Widget>[
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  child: FadeInImage(
                    image: NetworkImage(pharm.img),
                    placeholder: const AssetImage(AppImages.noImage),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(AppImages.noImage,
                          fit: BoxFit.fitWidth);
                    },
                    fit: BoxFit.fitWidth,
                    placeholderFit: BoxFit.fill,
                  ),
                ),
              ),
              // const Center(
              //   heightFactor: 4,
              //   child: CircularProgressIndicator(),
              // ),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 150),
                padding: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Get.theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            topLeft: Radius.circular(100)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 16.0, right: 12.0),
                        child: Text(
                          ("${pharm.name}"),
                          style: const TextStyle(
                            fontSize: 20,
                            //color: tdBlack,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 1.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.mainColor,
                  size: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: '${pharm.locName}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.onSurface,
                    ),
                    /*defining default style is optional */
                    children: const <TextSpan>[
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
            const SizedBox(
              height: 8,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 5.0, right: 1.0),
            //   child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //     const Icon(
            //       Icons.timer,
            //       color: AppColors.mainColor,
            //       size: 20,
            //     ),
            //     RichText(
            //       text: TextSpan(
            //         text: '${pharm.time} ',
            //         style: TextStyle(
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold,
            //           color: Get.theme.colorScheme.onSurface,
            //         ),
            //         /*defining default style is optional */
            //         children: <TextSpan>[
            //           TextSpan(
            //             text: "• no EX km",
            //             style: TextStyle(
            //               fontSize: 15,
            //               fontWeight: FontWeight.bold,
            //               color: Get.theme.colorScheme.onSurface,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ]),
            // ),
            const Divider(
              indent: 15,
              endIndent: 15,
              thickness: 1.2,
            ),
            const SizedBox(
              height: 100,
            ),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 20.0,
              animation: false,
              percent: pharm.boxStorage,
              center: Text(
                "${pharm.boxStorage * 100}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: const Text(
                "Box Storage",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    overflow: TextOverflow.clip),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: storageColor,
            ),

            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8bd5ff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 20,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size.fromHeight(48),
                            ),
                            child: Text(
                              "Help",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ))),
                    Container(
                        margin: const EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width * 0.38,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8bd5ff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 20,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size.fromHeight(48),
                            ),
                            child: Text(
                              "Location",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ))),
                  ],
                ),
              ),
            ),

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   //crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //    // const CircularProgressIndicator(),
            //     CircularPercentIndicator(
            //       radius: 60.0,
            //       lineWidth: 13.0,
            //       animation: false,
            //       percent: pharm.boxStorage,
            //       center: Text(
            //         "${pharm.boxStorage * 100}%",
            //         style: const TextStyle(
            //             fontWeight: FontWeight.bold, fontSize: 20.0),
            //       ),
            //       footer: const Text(
            //         "Box Storage",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 17.0,
            //             overflow: TextOverflow.clip),
            //       ),
            //       circularStrokeCap: CircularStrokeCap.round,
            //       progressColor: Colors.orange,
            //     ),
            //     const SizedBox(
            //       height: 16,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //           top: 20, right: 40, left: 40, bottom: 10),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           ElevatedButton(
            //             child: const Text("Call"),
            //             clipBehavior: Clip.hardEdge,
            //             onPressed: () => {},
            //             style: ElevatedButton.styleFrom(
            //               primary: Colors.green,
            //               textStyle: const TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 20,
            //                   fontStyle: FontStyle.normal),
            //             ),
            //           ),
            //           ElevatedButton(
            //             child: const Text("Location"),
            //             onPressed: () => {},
            //             style: ElevatedButton.styleFrom(
            //               //primary: Colors.green,
            //               textStyle: const TextStyle(
            //                   color: Colors.blue,
            //                   fontSize: 20,
            //                   fontStyle: FontStyle.normal),
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ]),
    );
  }
}
