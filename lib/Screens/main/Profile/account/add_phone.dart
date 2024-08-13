import 'package:akrem/Api/user_api.dart';
import 'package:akrem/Screens/main/Profile/account/phone_verification.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({super.key, this.phoneNumber = ""});

  final String phoneNumber;

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;
  var hasWhatsApp = false.obs;
  var phoneKey = GlobalKey<FormState>();

  sendCodeToPhone() async {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    // print(phoneKey.currentState?.validate());
    // if (phoneKey.currentState?.validate() == false) return;

    // if (!(phoneKey.currentState?.validate() ?? false)) {
    //    showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             actions: [
    //               TextButton(
    //                   onPressed: () {
    //                     Get.back();
    //                   },
    //                   child: const Text("Close")),
    //             ],
    //             title: const Text("The phone number is not valued"),
    //             content: const Text("The phone number is not valued try again"),
    //           ));
    //   return;
    // }

    // Navigator.push(
    //     context, SlideRoute(page: PhoneVerification(), slideFrom: 'bottom'));

    if (phoneNumber.isEmpty) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Close")),
                ],
                // title: const Text("have not login yet"),
                content: const Text("Please enter your phone number"),
              ));
    } else if (phoneNumber.length < 9) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Close")),
                ],
                // title: const Text("have not login yet"),
                content: Text(
                    'The phone number you entered is too short for the country: $countryName\n\nInclude your area code if you haven\'t'),
              ));
    } else if (phoneNumber.length > 11) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Close")),
                ],
                // title: const Text("have not login yet"),
                content: Text(
                    "The phone number you entered is too long for the country: $countryName"),
              ));
    } else {
      print("Button Pressed " + countryCode + phoneNumber);

      await UserAPI.changePhone(phone: phoneNumber,whatsApp: hasWhatsApp.value);

      await Get.to(() => PhoneVerification(
            phoneNumber: phoneNumber,
          ));
    }

    // ref.read(authControllerProvider).sendSmsCode(
    //   context: context,
    //   phoneNumber: "+$countryCode$phoneNumber",
    // );
  }

  showCountryPickerBottomSheet() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['EG'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: Colors.grey),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.language,
            color: Colors.grey,
          ),
          hintText: 'Search country by code or name',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.2),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Egypt');
    countryCodeController = TextEditingController(text: '20');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Phone',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Set up your phone number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                'Please enter your mobile number, and we will send you a PIN',
                style: TextStyle(fontSize: 16),
              )),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: const BorderSide(color: Colors.blueAccent),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: const BorderSide(color: Colors.blueAccent),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            Form(
              key: phoneKey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        onTap: showCountryPickerBottomSheet,
                        controller: countryNameController,
                        readOnly: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          suffix: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                            size: 22,
                          ),
                          // hintText: hintText,
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  SizedBox(
                      width: 70,
                      child: TextField(
                        onTap: showCountryPickerBottomSheet,
                        controller: countryCodeController,
                        readOnly: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixText: '+',
                          suffix: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                            size: 22,
                          ),
                          // hintText: hintText,
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length < 9) {
                        return 'The phone number you entered is too short for the country: ${countryNameController.text}\n\nInclude your area code if you haven\'t';
                      } else if (value.length > 10) {
                        return 'The phone number you entered is too long for the country: ${countryNameController.text}';
                      }
                      return null;
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      isDense: true,
                      suffix: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue,
                        size: 22,
                      ),
                      hintText: 'phone number',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              // height: 50,
              // margin: EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("this number has WhatsApp",
                      style: TextStyle(
                        fontSize: 13,
                      )),
                  Checkbox(
                      value: hasWhatsApp.value,
                      activeColor: Colors.green,
                      onChanged: (checked)
                          {
                            print("check wats");
                            setState(() {
                              hasWhatsApp.value = checked ?? false;
                            });
                          }),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Carrier charges may apply',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            Center(
                child: ElevatedButton(
              onPressed: () {
                sendCodeToPhone();
              },
              child: const Text('CHANGE NUMBER'),
            )),
          ],
        ),
      ),
    );
  }
}
