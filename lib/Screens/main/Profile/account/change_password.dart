import 'package:akrem/Api/user_api.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/input.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}


class _PasswordViewState extends State<PasswordView> {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController repeatNewPass = TextEditingController();
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomInputField(
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Current Password",
                      obscureText: true,
                      controller: currentPass,
                      //  validator: Validator.validatePassword,
                      label: "Current Password",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                    )),
                const SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomInputField(
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "New password",
                      obscureText: true,
                      controller: newPass,
                      validator: Validator.validatePassword,
                      label: "New password",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                    )),
                const SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomInputField(
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Conform new password",
                      obscureText: true,
                      controller: repeatNewPass,
                      validator: (password) {
                        if (newPass.text.isEmpty || password != newPass.text) {
                          return "Password is not confirmed";
                        }
                        if (password == newPass.text) {
                          return null;
                        }
                        return null;
                      },
                      label: "Conform new password",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                    )),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                     if (_formKey.currentState?.validate() == false) return;

                    try {
                      UserAPI.changePassword(
                          newPass: newPass.text, oldPass: currentPass.text);
                      Get.back();
                      showDialog(
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
                                    "Password has ben changed successfully"),
                                content: Text(
                                    "your new password has been set for use happy to help you today"),
                              ));
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Close"))
                                ],
                                title: const Text("some thing went wrong"),
                                content: Text(
                                    "some thing went wrong pleas make sure you enter valued data and try again"),
                              ));
                    }
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
    );


  }

}
