import 'package:akrem/Api/fake_api.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PharmacyItem extends StatelessWidget {
  final String? name;
  final String? location;
  final int? time;
  final String? distance;

  // final onToDoChanged;
  // final onDeleteItem;

  const PharmacyItem({
    Key? key,
    required this.name,
    required this.location,
    required this.time,
    required this.distance,
    // required this.onToDoChanged,
    // required this.onDeleteItem,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext builder) {
              return CupertinoPopupSurface(
                child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 400,
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Name ',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: ": ${name}",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Location ',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: ": ${location}",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Time ',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: ": ${time}",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Distance ',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: ": ${distance}",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        Image.asset(
                          "assets/Pharmacy.png",
                          scale: 1,
                        ),                      ],
                    ))),
              );
            },
          );

          // print('Clicked on Todo Item.');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        // leading: Icon(
        //   todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        //   color: tdBlue,
        // ),
        title: Text(
          (name ?? ""),
          style: const TextStyle(
            fontSize: 16,
            color: tdBlack,
            //decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              // print('Clicked on delete icon');
              //onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
