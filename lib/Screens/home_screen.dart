import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import '../widgets/pharmacy_card.dart';
import '../constants/app_colors.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pharmacyList = Pharmacy.pharmacyList();
  List<Pharmacy> _foundPharmacy = [];
  final _todoController = TextEditingController();
  Image image = Image.asset(AppImages.profileIcon);

  @override
  void initState() {
    _foundPharmacy = pharmacyList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [                      Container(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: 'Donation ',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                          /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                                text: "(${_foundPharmacy.length})",
                                style:
                                TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),

                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Nearby Branch ',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                            ),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: "(${_foundPharmacy.length})",
                                  style:
                                      TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                      for (Pharmacy Pharm in _foundPharmacy.reversed)
                        PharmacyItem(
                          name: Pharm.name,
                          location: Pharm.location,
                          time: Pharm.time,
                          distance: Pharm.distance,
                          // onToDoChanged: _handleToDoChange,
                          // onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Row(children: [
          //     Expanded(
          //       child: Container(
          //         margin: EdgeInsets.only(
          //           bottom: 20,
          //           right: 20,
          //           left: 20,
          //         ),
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 20,
          //           vertical: 5,
          //         ),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           boxShadow: const [
          //             BoxShadow(
          //               color: Colors.grey,
          //               offset: Offset(0.0, 0.0),
          //               blurRadius: 10.0,
          //               spreadRadius: 0.0,
          //             ),
          //           ],
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: TextField(
          //           controller: _todoController,
          //           decoration: InputDecoration(
          //               hintText: 'Add a new todo item',
          //               border: InputBorder.none),
          //         ),
          //       ),
          //     ),
          // Container(
          //   margin: EdgeInsets.only(
          //     bottom: 20,
          //     right: 20,
          //   ),
          //   child: ElevatedButton(
          //     child: Text(
          //       '+',
          //       style: TextStyle(
          //         fontSize: 40,
          //       ),
          //     ),
          //     onPressed: () {
          //       _addToDoItem(_todoController.text);
          //     },
          //     style: ElevatedButton.styleFrom(
          //       primary: tdBlue,
          //       minimumSize: Size(60, 60),
          //       elevation: 10,
          //     ),
          //   ),
          // ),
          //   ]),
          // ),
        ],
      ),
    );
  }

  // void _addToDoItem(String toDo) {
  //   setState(() {
  //     todosList.add(Pharmacy(
  //       id: DateTime.now().millisecondsSinceEpoch.toString(),
  //       todoText: toDo,
  //     ));
  //   });
  //   _todoController.clear();
  // }

  void _runFilter(String enteredKeyword) {
    List<Pharmacy> results = [];
    if (enteredKeyword.isEmpty) {
      results = pharmacyList;
    } else {
      results = pharmacyList
          .where((item) =>
              item.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundPharmacy = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: image,
          ),
        ),
      ]),
    );
  }
}
