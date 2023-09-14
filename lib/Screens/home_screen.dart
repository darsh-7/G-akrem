import 'package:akrem/Api/fake_api.dart';
import 'package:flutter/material.dart';
import '../widgets/pharmacy_card.dart';
import '../constants/app_colors.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Pharmacy.pharmacyList();
  List<Pharmacy> _foundPharmacy = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundPharmacy = todosList;
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
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All Pharmacy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
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
            ]),
          ),
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
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.name!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundPharmacy = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
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
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  Image.asset('assets/profileimage.png'),
          ),
        ),
      ]),
    );
  }
}
