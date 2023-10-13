//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:akrem/widgets/input.dart';
import 'package:akrem/widgets/appbar.dart';
import 'package:akrem/widgets/scrollable_column.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage() : super();

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  late Color myColor;
  late Size mediaSize;

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _phoneController = TextEditingController();
  bool hasWhatsApp = false;
  bool _agreeWithTermsAndConditions = false;
  double statusBarHeight = 20;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/medicBackground.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body:
        Stack(children: [
          // Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.medical_services_outlined,
            size: 50,
            color: Colors.white,
          ),
          Text(
            "Akrem",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Get.theme.colorScheme.onBackground,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4, right: 8, left: 8),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 600,
          width: double.infinity,
          color: Colors.transparent,
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Column(children: [
                Text(
                  "Welcome to Akrem",
                  style: TextStyle(
                      color: myColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
                _buildGreyText("Please Register with your information"),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: "First Name",
                      controller: _firstNameController,
                      validator: Validator.validateName,
                      label: "First Name",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(46),
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      width: 140,
                    ),
                    CustomInputField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Last Name",
                      controller: _lastNameController,
                      validator: Validator.validateName,
                      label: "Last Name",
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(46),
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      width: 140,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomInputField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  controller: _emailController,
                  validator: Validator.validateEmail,
                  label: "Email",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(360),
                  ],
                ),
                const SizedBox(height: 12),
                CustomInputField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                  validator: Validator.validatePassword,
                  label: "Password",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                ),
                const SizedBox(height: 12),
                CustomInputField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Password Confirmation",
                  label: "Password Confirmation",
                  obscureText: true,
                  controller: _passwordConfirmationController,
                  validator: (password) {
                    if (_passwordConfirmationController.text.isEmpty ||
                        password != _passwordConfirmationController.text) {
                      return "Password is not confirmed";
                    }
                    if (password == _passwordConfirmationController.text) {
                      return null;
                    }
                  },
                ),
                // const SizedBox(height: 12),
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       CustomInputField(
                //         keyboardType: TextInputType.number,
                //         hintText: "Phone",
                //         label: "Phone",
                //         //obscureText: true,
                //         controller: _phoneController,
                //         validator: Validator.validatePhone,
                //         inputFormatters: [
                //           LengthLimitingTextInputFormatter(11),
                //         ],
                //         width: 260,
                //       ),
                //       Container(
                //         width: 50,
                //         height: 60,
                //         child:
                //         Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Text("WhatsApp",style: TextStyle(
                //               fontSize: 10,
                //               color: Colors.green[300],
                //             ),),
                //             Checkbox(
                //               value: hasWhatsApp,
                //               activeColor: Colors.green,
                //               onChanged: (checked) =>
                //                   setState(() => hasWhatsApp = checked ?? false),
                //             ),
                //           ],
                //         ),
                //       )
                //     ]),
                const SizedBox(height: 12),
                CustomCheckbox(
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "By creating an account you agree to our",
                          style: TextStyle(
                            color: Color(0xFFa8a8a7),
                          ),
                        ),
                      ),
                      TextButton(
                        child: const Text('Terms & Conditions'),
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext builder) {
                              return CupertinoPopupSurface(
                                child: Container(
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: mediaSize.height,
                                    child: ListView(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: statusBarHeight),
                                              child: null),
                                          RichText(
                                            text: const TextSpan(
                                              text: 'good to see you \n',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                              /*defining default style is optional */
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "bla bla \nbla bla \nbla bla \nbla bla \nbla bla \nbla blabla bla \n"
                                                        " \nbla bla \nbla bla \nbla bla \nbla bla \nbla bla \nbla bla \n",
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/Pharmacy.png",
                                            scale: 1,
                                          ),
                                        ],
                                      )
                                    ])),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  value: _agreeWithTermsAndConditions,
                  onChanged: (checked) => setState(
                      () => _agreeWithTermsAndConditions = checked ?? false),
                ),
              ]),
            ),
        const SizedBox(height: 4),
        _buildOtherLogin(),
          ]),
        ),
      ],
    );
  }


  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 4),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == false) return;
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
                          title: const Text("form content"),
                          content: const Text("we are good"),
                        ));
                if (_agreeWithTermsAndConditions != true) {
                  return;
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                shadowColor: Colors.grey.shade700,
                minimumSize: const Size.fromHeight(48),
                backgroundColor: myColor,
              ),
              child: const Text("Register")),
          const SizedBox(height: 12),
          _buildGreyText("Or Register with"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(
                  icon: Image.asset(
                "assets/socialIcons/google.png",
                width: 32,
                height: 32,
              )),
              Tab(
                  icon: Image.asset(
                "assets/socialIcons/facebook.png",
                width: 32,
                height: 32,
              )),
              Tab(
                icon: Icon(
                  Icons.discord,
                  color: Colors.deepPurpleAccent,
                  size: 35,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(
                  color: Color(0xFFb8b8b8),
                ),
              ),
              TextButton(
                child: const Text("Login"),
                onPressed: () => {
                  Get.offAll(const LoginPage()),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
Widget _buildGreyText(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.grey),
  );
}

