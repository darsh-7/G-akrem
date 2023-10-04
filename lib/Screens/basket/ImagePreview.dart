import 'dart:io';

import 'package:akrem/Screens/basket/add_medic.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/log_manager.dart';

class ImagePreview extends StatefulWidget {
  ImagePreview({
    super.key,
  });

  @override
  State<ImagePreview> createState() => _ImagePreview();
}
late File pic;
class _ImagePreview extends State<ImagePreview> {
  @override


  @override
  Widget build(BuildContext context) {
    File pic=Get.arguments["picFile"];
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Stack(children: <Widget>[

          ClipRRect(
            // borderRadius: const BorderRadius.all(Radius.elliptical(30, 50)),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(20.0)),
            //const BorderRadius.all(Radius.circular(20.0)),
            child: Image.file(
              pic,
              // width: 400,
              height: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(30),
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.negative,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RawMaterialButton(
                        child: Text("Try Again",style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          pic.delete();
                      Navigator.pop(context);
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: RawMaterialButton(
                        child: Text("Save",style: TextStyle(fontSize: 20),), onPressed: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddMedic(pic: pic)),
                      );

                    }),
                  ),

                ],
              ),
            )
          ],
        ),
      ]),
    );
  }

}
