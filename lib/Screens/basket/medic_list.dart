import 'package:akrem/Screens/basket/take_pic.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../constants/medic.dart';
import '../../widgets/medic_card.dart';
import '../../constants/app_colors.dart';
import 'add_medic.dart';
import 'empty_items.dart';

class MedicList extends StatefulWidget {
  final List<CameraDescription> cameraDescription;

  MedicList({
    super.key,
    required this.cameraDescription,
  });

  @override
  State<MedicList> createState() =>
      _MedicList(cameraDescription: cameraDescription);
}

class _MedicList extends State<MedicList> {
  final List<CameraDescription> cameraDescription;

  _MedicList({
    required this.cameraDescription,
  });

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

  void clearList() {
    MedicManager.medics.clear();
    List<Medic> results = MedicManager.medics;
    setState(() {
      _foundMedic = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.backGround,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TakePic(cameraDescription: cameraDescription)));

          // await Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => TakePic(cameraDescription: cameraDescription)),
          // );
          refreshList();
        },
      ),

      //appBar: _buildAppBar(),
      body: Stack(
        children: [
          if (_foundMedic.isEmpty) const EmptyItemsScreen(),
          Container(
              child: Column(
            children: [
              //TextButton(onPressed: () => {refreshList()}, child: Text("tap")),
              //const LinearProgressIndicator(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 80, top: 10),
                  children: [
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
                          index: i,
                          onDelete: (i) {
                            MedicManager.removeMedic(index: i);
                            refreshList();
                          },
                        ),
                      ),
                  ],
                ),
              ),
              if (!_foundMedic.isEmpty)
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: RawMaterialButton(
                          child: const Text("Proceed",
                              style: TextStyle(fontSize: 20)),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                ),

            ],
          ))
        ],
      ),
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
        // Container(
        //   height: 40,
        //   width: 120,
        //   child: ClipRRect(
        //       borderRadius: BorderRadius.circular(20),
        //       child: IconButton(
        //         icon: const Icon(Icons.fiber_smart_record),
        //         onPressed: () => {
        //           //TODO : add voice recognition for adding items
        //         },
        //       )),
        // ),
        Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red.withOpacity(0.8),
          ),
          child: TextButton(
            child: Text(
              "Clear",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close")),
                      TextButton(
                          onPressed: () {
                            clearList();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Clear",style: TextStyle(color: Colors.red),))
                    ],
                    title: const Text("are you sure"),
                    content: const Text("click Clear if you are sure to remove all items from the basket"),
                  ));
            },
          ),
        ),
      ]),
    );
  }
}
