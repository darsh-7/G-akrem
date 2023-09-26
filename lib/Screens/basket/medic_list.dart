import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../../constants/medic.dart';
import '../../widgets/medic_card.dart';
import '../../constants/app_colors.dart';
import 'add_medic.dart';
import 'empty_items.dart';

class MedicList extends StatefulWidget {
  MedicList({Key? key}) : super(key: key);

  @override
  State<MedicList> createState() => MMedicList();
}

class MMedicList extends State<MedicList> {
  static List<Medic> foundMedic = MedicManager.medics;
  late List<Medic> _foundMedic;

  Image image = Image.asset(AppImages.profileIcon);

  @override
  void initState() {
    _foundMedic = foundMedic;
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedic()),
          );
          refreshList();
        },
      ),

      //appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              child: Column(
            children: [
              //TextButton(onPressed: () => {refreshList()}, child: Text("tap")),
              const LinearProgressIndicator(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 80, top: 10),
                  children: [
                    // if(_foundMedic.isEmpty)
                    //   const EmptyItemsScreen(),

                    for (var i = 0; i < _foundMedic.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: MedicCard(
                          img: _foundMedic[i].img,
                          name: _foundMedic[i].name,
                          pill: _foundMedic[i].pill,
                          bar: _foundMedic[i].bar,
                          date: _foundMedic[i].date,
                          index : i,
                          refresh: (i) {
                            MedicManager.removeMedic(index: i);
                            refreshList();
                          },
                        ),
                      ),
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
