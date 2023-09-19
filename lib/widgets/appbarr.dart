
import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
AppBar buildAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.mainColor,
    elevation: 0,
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Icon(
          Icons.location_on_rounded,
          color: Colors.redAccent,
          size: 30,
        ),
        const Text("Location"),
        Transform.rotate(
          angle: 270 * math.pi / 180,
          child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
      ]),
      Container(
        height: 40,
        width: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    ]),
  );
}

