import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:akrem/Api/api_key.dart';
import 'package:akrem/Api/user_api_model.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/medic.dart';
import 'package:akrem/model/order_history.dart';
import 'package:akrem/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

import '../model/donation_history.dart';

class DonationApi {
  static final UserController userController = Get.find();


  static Future<String> postImageToServer(File imageFile) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "$akrem_url" +
              "api/MedicineDetectionModel/DetectMedicineInformation?AllowStripsOCR=false",
        ));

   // request.fields[‘ProductId’] = productId.toString();

    request.files.add(http.MultipartFile.fromBytes("file", imageFile.readAsBytesSync(),filename: imageFile!.path));

    var res = await request.send();

  var response = await http.Response.fromStream(res);
    print("response : ${response.body}");

    final responseJson = jsonDecode(response.body);

    return responseJson;
  }

  static Future<Map<String,dynamic>> addItemToCart1(Medic medic) async {

    print("add tok : ${userController.user.token}");

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File imageFile = File('$tempPath/image.jpg');
    await imageFile.writeAsBytes(medic.img);

    try {
     var respons = await http.post(
          Uri.parse(
            "$akrem_url" + "p",
          ),
          headers: {
            // "content-type": "application/json",
            // "accept": "application/json",
            "Authorization": "bearer ${userController.user.token}",
          },
          body:{
            "hasWhatsApp": imageFile.readAsBytes().asStream(),
          });

      final responseJson = jsonDecode(respons.body);
      print("responseJson : "+ responseJson);
      return responseJson; // Return the response string
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<bool> addItemToCart({required Medic medic,int medID=1 ,int,int medtyp=1}) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "$akrem_url" + "/api/Cart/AddOneItemToCart",
        ));

    print("add tok : ${userController.user.token}");

    request.headers.addAll({
      // "content-type": "application/json",
      // "accept": "application/json",
      "Authorization": "bearer ${userController.user.token}"
    });


    // request.files.add(http.MultipartFile.fromBytes(
    //   'Image',
    //   medic.img,
    //   filename: 'image.jpg', // Provide a suitable filename
    //   contentType: MediaType('image', 'jpg'), // Adjust content type if needed
    // ));
    //
    //

    // //request.fields["MedicineCategoryId"] = medic.bar.toString();
    // request.fields["CorrectName"] = medic.name.toString();
    // request.fields["CorrectConcentration"] = "medic";
    // request.fields["MedicineForm"] = 0.toString();
    // request.fields["MedicineCategoryId"] = medic.bar.toString();
    // request.fields["NumberOfStrips"] = medic.bar.toString();
    // request.fields["ExpirationDate"] = medic.date.toString();
    // request.fields["NumberOfPills"] = medic.pill.toString();


    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File imageFile = File('$tempPath/image.jpg');
    await imageFile.writeAsBytes(medic.img);



    request.files.add(http.MultipartFile(
      'Image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: imageFile.path.split('/').last,
      contentType: MediaType('image', 'jpg'), // Adjust content type if needed
    ));



    // request.fields["MedicineCategoryId"] = medic.bar.toString();
    // print(medic.toString());
    //
    // request.fields["CorrectName"] = medic.name.toString();
    // request.fields["CorrectConcentration"] = "medic";
    // request.fields["MedicineForm"] = 0.toString();
    // request.fields["MedicineCategoryId"] = medic.bar.toString();
    // request.fields["NumberOfStrips"] = medic.bar.toString();
    // request.fields["ExpirationDate"] = medic.date.toString();
    // request.fields["NumberOfPills"] = medic.pill.toString();


    request.fields["MedicineCategoryId"] = "4712"   /*medID.toString()*/;
    //print(medic.toString());

    request.fields["CorrectName"] = medic.name.toString();
    request.fields["CorrectConcentration"] = medic.name.toString();
    request.fields["MedicineForm"] = medic.medtyp.toString()??"1";


    request.fields["NumberOfStrips"] = "2"  /*medic.bar.toString()*/;
    request.fields["ExpirationDate"] ="${medic.date?.month}-${medic.date?.day}-${medic.date?.year}";
    request.fields["Quantity"] = medic.bar.toString();

    request.fields["NumberOfPills"] = medic.pill.toString();


    // request.files.add(http.MultipartFile(
    //   'Image ',
    //   imageFile.readAsBytes().asStream(),
    //   imageFile.lengthSync(),
    //   filename: imageFile.path.split('/').last,
    //   contentType: MediaType('image', 'jpg'),
    // ));
    //
    //


    try {
      var response = await request.send();
      final respStr = await response.stream.bytesToString(); // Convert the response to string
      print(respStr);
      // final responseJson = jsonDecode(respStr);
      // print("responseJson : "+responseJson);

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        return true; // Return the response string

      } else {
        print(' Server responded with status code ${response.statusCode}');
        return false; // Return the response string
      }


    } catch (e) {
      print('Error occurred while trying to upload image: $e');
      throw e;
    }
  }

  // static Future<String> postImageToServer(File imageFile) async {
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //         "$akrem_url" + "api/MedicineDetectionModel/DetectMedicineInformation?AllowStripsOCR=false",
  //       ));
  //   imageFile.printInfo();
  //   print("imageFile : ${imageFile.path} \n");
  //
  //   request.files.add(http.MultipartFile(
  //     'image',
  //     // consider 'image' as the field name specified by the server for file upload
  //     imageFile.readAsBytes().asStream(),
  //     imageFile.lengthSync(),
  //     filename: imageFile.path.split('/').last,
  //     contentType:
  //         MediaType('image', 'jpg'), // change 'jpeg' to the type of your image
  //   ));
  //
  //   try {
  //     var response = await request.send();
  //     print("response : ${jsonDecode(response.toString())}");
  //
  //     if (response.statusCode == 200) {
  //       print('Image uploaded successfully!');
  //     } else {
  //       print(
  //           'Failed to upload image. Server responded with status code ${response.statusCode}');
  //     }
  //
  //   } catch (e) {
  //     print('Error occurred while trying to upload image: $e');
  //   }
  //   return "response.toString()";
  //
  // }

  static Future<int> supOrder({required double latitude,
    required double  longitude,
  required String address,
    required String phoneNumber}) async {
    //var response = await http.get(Uri.parse(BASE_URL));


    try {

      print("send:\n" +
          "latitude: $latitude\n" + "longitude: $longitude\n" + "address: $address\n" + "phoneNumber: $phoneNumber\n");

      var response = await http.post(
        Uri.parse(
          "$akrem_url" + "api/Orders/CreateDonationOrder",
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
        body: jsonEncode({

          "latitude":"30.123124124" /*latitude.toString()*/,
          "longitude": "30.123124124"/*longitude.toString()*/,
          "address": "akljwdghlkajwgdhklawd"/*address.toString()*/,
          "areaId": 1,
          "phoneNumber": "01002110356"/*phoneNumber.toString()*/
        }),
      );
      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");
      return response.statusCode;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }
  static Future<bool> checkUpComingDonation() async {
    //var response = await http.get(Uri.parse(BASE_URL));


    try {

      var response = await http.post(
        Uri.parse(
          "$akrem_url" + "api/Orders/CheckHavingOrder",
        ),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
      );

      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("${response.body}");
      return response.body == "true";
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static void /*Future<Map<String, dynamic>>*/ ocr(binaryFile) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      var response = await http.post(
          Uri.parse(
            "$akrem_url" +
                "api/MedicineDetectionModel/DetectMedicineInformation",
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: {
            "AllowStripsOCR": false,
            "file": binaryFile,
          });
      if (response.statusCode == 200) {
        //  return {'statusCode': response.statusCode};
      }

      print(
          "post : ${response.headers}\n else: ${response.persistentConnection} code :${response.statusCode}");
      print("response : ${jsonDecode(response.body)}");

      final data = jsonDecode(response.body);
      final details = {
        'user': UserApiModel.fromJson(data),
        'statusCode': response.statusCode
      };
      //  return details;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<void> resetPassword(String email) async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      await http.get(
        Uri.parse(
          "$akrem_url" + "api/Authentication/ForgotPassword/${email}",
        ),
      );
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
      // return error.toString();
    }
  }

  static Future<List<DonationHistory>> donationHistory() async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     BASE_URL,
      //     "api/v1/products",);
      // var response = await http.get(uri);
      var response = await http.get(
          Uri.parse("$akrem_url" + "api/DonatedMedicines/GetAll"));
      print("response : ${jsonDecode(response.body)}");
      var data = jsonDecode(response.body);

      List<DonationHistory> tempList = [];
      // if (response.statusCode != 200) {
      //   throw data["error"];
      // }
      for (var v in data["content"]) {
        tempList.add(DonationHistory(

          id: v["id"],

        ));
        // print("V $v \n\n");
      }
      //return MarketContent.fromJson(data["content"]);
      return tempList;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

  static Future<bool> cancelOrder() async {
    //var response = await http.get(Uri.parse(BASE_URL));

    try {
      // final uri = Uri.https(
      //     BASE_URL,
      //     "api/v1/products",);
      // var response = await http.get(uri);
      var response;
      response = await http.post(Uri.parse(akrem_url + "api/Orders/DeleteLastDonationOrder"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": "bearer ${userController.user.token}"
        },
        // body: jsonEncode({
        //   "marketMedicineId": id,
        // }),
      );
      //print("response : ${jsonDecode(response.body)}");

      //return MarketContent.fromJson(data["content"]);
      return response.statusCode == 200;
    } catch (error) {
      log("An error occurred $error");
      throw error.toString();
    }
  }

}
