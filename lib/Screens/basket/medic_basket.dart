
import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/empty_items.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/medic.dart';
import 'package:flutter/scheduler.dart';

import 'medic_list.dart';

class MedicBasket extends StatelessWidget {
  MedicBasket({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: MedicList(),
    );
  }

  Widget buildItemsScreen() {
    return Column(
      children: [
        if (MedicManager.medics.isNotEmpty)
          MedicList()
        else
          //Text("data"),
          const EmptyItemsScreen(),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text("Donation basket"),
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
