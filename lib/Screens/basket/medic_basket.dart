import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/Screens/basket/empty_items.dart';
import 'package:akrem/Screens/show_list.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/widgets/input.dart';
import 'package:akrem/widgets/medic_item.dart';
import 'package:flutter/material.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/medic.dart';
import 'dart:math' as math;

class MedicBasket extends StatelessWidget {
  const MedicBasket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedic()),
          );
        },
      ),
      body: EmptyItemsScreen(),
    );
  }

  Widget buildItemsScreen() {
    return Column(
      children: [
        if (MedicManager.medics.isEmpty ) ...{
          const EmptyItemsScreen(),
        } else ...{
          const EmptyItemsScreen(),
          //ShowList(),
        },
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



  Widget ShowList() {
    return Stack(
      children: [
        Container(
            child:const Text("tt")
          // ListView(
          //   children: [
          //     for (Pharmacy Pharm in _foundPharmacy.reversed)
          //       Padding(
          //         padding:
          //         const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          //         child: PharmacyItem(
          //           name: Pharm.name,
          //           location: Pharm.location,
          //           time: Pharm.time,
          //           distance: Pharm.distance,
          //           // onToDoChanged: _handleToDoChange,
          //           // onDeleteItem: _deleteToDoItem,
          //         ),
          //       )
          //   ],
          // ),
        )
      ],
    );
  }
}
