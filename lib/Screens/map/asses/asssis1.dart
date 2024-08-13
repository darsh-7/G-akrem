
import 'package:akrem/Api/api_key.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;



class AssistantMethods {
  static Future<String> searchCoordinateAddress(LatLng position) async{
    String placeAddress = "";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?"
        "latlng=${position.latitude},${position.longitude}&key=$map";

    var response = await RequestAssistant.getRequest(url);

    placeAddress = response["results"][0]["formatted_address"];

    print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

    print("This is your address:: $placeAddress");

    return placeAddress;

  }
}


class RequestAssistant {

  static Future<dynamic> getRequest(String url) async{
    http.Response response = await http.get(Uri.parse(url));

    try{
      if (response.statusCode == 200){
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      }
      else {
        return "failed";
      }
    }
    catch(e){
      return "failed";

    }
  }
}