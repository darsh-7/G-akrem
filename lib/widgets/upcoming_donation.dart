import 'package:akrem/Api/donation_api.dart';
import 'package:akrem/Screens/basket/edit_donation.dart';
import 'package:akrem/Screens/basket/medic_list.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UpcomingDonationCard extends StatelessWidget {
  const UpcomingDonationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        //color: Theme.of(context).primaryColor.withOpacity(0.8),
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
            SvgPicture.asset(
              "assets/icons/delivery_van.svg",
              width: 45,
              fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
            ),
            // SvgPicture.asset(
            //   "assets/icons/delivery_van.svg",
            //   width: 45,
            //   fit: BoxFit.cover,color: Colors.white,
            // ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "coming to receive \ndonation from you\n ❤️",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),

                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 34,
                    width: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),                    // padding: const EdgeInsets.symmetric(
                    //     vertical: 22, horizontal: 20),
                    child: TextButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // Get.to(EditDonation());
                       await DonationApi.cancelOrder();
                        Get.offAll(() => NavigationBarApp());
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 6,
              //     horizontal: 8.0,
              //   ),
              //   decoration: BoxDecoration(
              //       color: Colors.white10,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: const Row(
              //     children: [
              //       Icon(
              //         Icons.calendar_month_outlined,
              //         size: 18,
              //         color: Colors.white,
              //       ),
              //       Padding(
              //         padding: EdgeInsets.only(left: 6, right: 14),
              //         child: Text(
              //           "Today",
              //           style: TextStyle(color: Colors.white),
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.only(right: 8),
              //         child: Icon(
              //           Icons.timer,
              //           size: 18,
              //           color: Colors.white,
              //         ),
              //       ),
              //       Text(
              //         "13:30 - 15:30 AM",
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
