// //AIzaSyC79noCguhAfYieDJejvlj9gfXBwm1sFhY
// //import 'package:geolocator/geolocator.dart';
// import 'package:akrem/Screens/main/NavigationBar.dart';
// import 'package:akrem/constants/app_images.dart';
// import 'package:akrem/widgets/input.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
//
// import '../../Api/api_key.dart';
//
// class SelectLocationText extends StatefulWidget {
//   SelectLocationText({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<SelectLocationText> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title ?? ""),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(height: 20),
//             placesAutoCompleteTextField(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   placesAutoCompleteTextField() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: GooglePlaceAutoCompleteTextField(
//         textEditingController: goo,
//         googleAPIKey: map,
//         inputDecoration: InputDecoration(
//           hintText: "Search your location",
//           border: InputBorder.none,
//           enabledBorder: InputBorder.none,
//         ),
//         debounceTime: 400,
//         countries: ["in", "fr"],
//         isLatLngRequired: false,
//         getPlaceDetailWithLatLng: (Prediction prediction) {
//           print("placeDetails" + prediction.lat.toString());
//         },
//
//         itemClick: (Prediction prediction) {
//           controller.text = prediction.description ?? "";
//           controller.selection = TextSelection.fromPosition(
//               TextPosition(offset: prediction.description?.length ?? 0));
//         },
//         seperatedBuilder: Divider(),
//         // OPTIONAL// If you want to customize list view item builder
//         itemBuilder: (context, index, Prediction prediction) {
//           return Container(
//             padding: EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Icon(Icons.location_on),
//                 SizedBox(
//                   width: 7,
//                 ),
//                 Expanded(child: Text("${prediction.description??""}"))
//               ],
//             ),
//           );
//         },
//
//         isCrossBtnShown: true,
//
//         // default 600 ms ,
//       ),
//     );
//   }
// }