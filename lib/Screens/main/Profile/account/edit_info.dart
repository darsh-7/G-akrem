import 'package:akrem/Api/user_api.dart';
import 'package:akrem/Screens/main/Profile/account/account_screen.dart';
import 'package:akrem/services/validator.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class EditView extends StatefulWidget {
  EditView({super.key,this.email,this.fName,this.lName});

  String? email;
  String? fName;
  String? lName;

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool edit =false;

  @override
  void initState() {
    emailController.text= widget.email??"";
    fNameController.text= widget.fName??"";
    lNameController.text= widget.lName??"";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Account info',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  edit = !edit;
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: const Text('Edit'),
            ),
          ],
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomInputField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                        controller: emailController,
                        validator: Validator.validateEmail,
                        label: "Email",
                        enabled: edit,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomInputField(
                        hintText: "First Name",
                        validator: Validator.validateName,
                        label: "First Name",
                        enabled: edit,
                        controller: fNameController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomInputField(
                        hintText: "Last Name",
                        controller: lNameController,
                        validator: Validator.validateName,
                        label: "Last Name",
                        enabled: edit,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                      )),
                  if(edit)
                    Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == false) return;
                            if(emailController.text != widget.email)
                            try {
                              UserAPI.changeEmail(email: emailController.text);
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Close"))
                                    ],
                                    title: const Text(
                                        "Check your new email"),
                                    content: Text(
                                        "Check your new email to conform happy to help you today"),
                                  ));
                            } catch (e) {
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Get.back();
                                            await userController.fetchNewUser();
                                          },
                                          child: const Text("Close"))
                                    ],
                                    title: const Text("some thing went wrong "),
                                    content: Text(
                                        "some thing went wrong with changing your email please make sure you enter valued data and try again"),
                                  ));
                            }
                            if(fNameController.text != widget.fName||lNameController.text != widget.lName)
                              try {
                                UserAPI.changeName(fName: fNameController.text,lName: lNameController.text);
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              Get.back();
                                              await userController.fetchNewUser();
                                            },
                                            child: const Text("Close"))
                                      ],
                                      title: const Text(
                                          "your new name has been set"),
                                      content: Text(
                                          "your name has been changed happy to help you today"),
                                    ));
                              } catch (e) {
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text("Close"))
                                      ],
                                      title: const Text("some thing went wrong "),
                                      content: Text(
                                          "some thing went wrong with changing your email please make sure you enter valued data and try again"),
                                    ));
                              }
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent, elevation: 0),
                          child: const Text('Confirm'),
                        )),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
