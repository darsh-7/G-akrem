import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../../constants/medic.dart';
import '../../widgets/medic_card.dart';
import '../../constants/app_colors.dart';

class MedicList extends StatefulWidget {
  MedicList({Key? key}) : super(key: key);

  @override
  State<MedicList> createState() => MMedicList();
}


class MMedicList extends State<MedicList> {
  static List<Medic> foundMedic = MedicManager.medics;
  late List<Medic> _foundMedic ;
  Image image = Image.asset(AppImages.profileIcon);
  Key refreshKey = UniqueKey();
  @override
  void initState() {
    _foundMedic= foundMedic;
    super.initState();
  }


   void refreshList() {
    List<Medic> results = MedicManager.medics;
    setState(() {
      _foundMedic = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      //appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              child: Column(
            children: [
              TextButton(onPressed:()=> {refreshList()}, child: Text("tap")),
              LinearProgressIndicator(),
              Expanded(
                child: ListView(
                  key: refreshKey,
                  padding: const EdgeInsets.only(bottom: 80, top: 10),
                  children: [
                    // Container(
                    //   margin: const EdgeInsets.only(
                    //     top: 0,
                    //     bottom: 10,
                    //   ),
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 0, horizontal: 20),
                    //   child: RichText(
                    //     text: const TextSpan(
                    //       text: 'Donation ',
                    //       style: TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w500,
                    //           color: Colors.black),
                    //       /*defining default style is optional */
                    //       children: <TextSpan>[
                    //         TextSpan(
                    //             text: "(4)", //"(${_foundPharmacy.length})",
                    //             style: TextStyle(color: Colors.red)),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    for (Medic medic in foundMedic.reversed)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: MedicCard(
                            img: Image.asset(AppImages.pharmacy),
                            name: medic.name,
                            pill: medic.pill,
                            bar: medic.bar,
                            date: medic.date),
                      )
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}


