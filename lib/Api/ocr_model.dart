import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:akrem/Api/api_key.dart';
import 'package:akrem/Api/user_api_model.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:akrem/model/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class OcRModelAPI {
  static final UserController userController = Get.find();


  // static Future<String> postImageToServer(File imageFile) async {
  //   var request = http.MultipartRequest(
  //       "POST",
  //       Uri.parse(
  //         "$akrem_url" +
  //             "api/MedicineDetectionModel/DetectMedicineInformation?AllowStripsOCR=false",
  //       ));
  //
  //  // request.fields[‘ProductId’] = productId.toString();
  //
  //   request.files.add(http.MultipartFile.fromBytes("file", imageFile.readAsBytesSync(),filename: imageFile!.path));
  //
  //   var res = await request.send();
  //
  // var response = await http.Response.fromStream(res);
  //   print("response : ${response.body}");
  //
  //   final responseJson = jsonDecode(response.body);
  //
  //   return responseJson;
  // }

  static Future<Map<String,dynamic>> postImageToServer(File imageFile) async {


    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "https://sensible-clearly-guinea.ngrok-free.app/GetDetectedMedicineInfo/?allowStripRecognition=false",
        ));

    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //       "http://localhost:44343/api/RespberryPi/RespberryPiUploadImage",
    //     ));



    request.files.add(http.MultipartFile(
      'Image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: imageFile.path.split('/').last,
      contentType: MediaType('image', 'jpg'),
    ));

    try {
      var response = await request.send();
      final respStr = await response.stream.bytesToString(); // Convert the response to string

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else {
        print('Failed to upload image. Server responded with status code ${response.statusCode}');
        return {'responseJson': 0};
      }
      print(respStr);
      final responseJson = jsonDecode(respStr);
      print(responseJson);
      return responseJson; // Return the response string
    } catch (e) {
      print('Error occurred while trying to upload image: $e');
      return {'responseJson': 0};
      // throw e;
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
      if (response.statusCode == 403) {
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
}
