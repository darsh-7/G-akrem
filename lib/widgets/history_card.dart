import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.title,
    required this.id,
    required this.phoneNumber,
    required this.arrivedDate,
    required this.address,
    required this.orderStatuses,

    this.textColor,
  }) : super(key: key);

  final String title;
  final String id;
  final String phoneNumber;
  final String arrivedDate;
  final String address;
  final int orderStatuses;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? AppColors.mainColor : AppColors.mainColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 4), // Shadow position
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 8), // Shadow position
          ),
        ],
      ),
      child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          // leading: Container(
          //     width: 40,
          //     height: 40,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(100),
          //       color: iconColor.withOpacity(0.1),
          //     ),
          //     child: Text("state:\n"+ ((orderStatuses == 0)? "pending" : "done"),
          //         style: Theme.of(context)
          //             .textTheme
          //             .titleSmall
          //             ?.apply(color: textColor))),
          title: Column(
            children: [
          Text("state: "+ ((orderStatuses == 0)? "pending" : "done"),
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.apply(color: textColor)),
              Divider(),
              Text("address :"+address,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.apply(color: textColor)),
              Text("phoneNumber :"+phoneNumber + "\n" + "arrivedDate :"+arrivedDate,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.apply(color: textColor)),
            ],
          )),
    );
  }
}
