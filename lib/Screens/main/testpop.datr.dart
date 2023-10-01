import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:akrem/services/validator.dart';
import 'package:akrem/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class LoginPagee extends StatefulWidget {
  const LoginPagee({super.key});

  @override
  State<LoginPagee> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPagee> {
  late Color myColor;
  late Size mediaSize;

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _agreeWithTermsAndConditions = false;
  bool rememberUser = false;
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
          image: const AssetImage(AppImages.profileIcon),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(children: [
            Text(
              "Welcome to Akrem",
              style: TextStyle(
                  color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
            ),
            _buildGreyText("Please Register with your information"),
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
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
            const SizedBox(height: 24),
            CustomInputField(
              keyboardType: TextInputType.visiblePassword,
              hintText: "Password Confirmation",
              label: "Password Confirmation",
              obscureText: true,
              controller: _passwordConfirmationController,
              validator: (String? password) {
                if (password == null) {
                  return null;
                }
                if (password != _passwordConfirmationController.value.text) {
                  return "Password is not confirmed";
                }
              },
            ),
            const SizedBox(height: 24),
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
                                child: ListView(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: statusBarHeight),
                                              child: null),
                                          RichText(
                                            text: TextSpan(
                                              text: 'good to see you \n',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                              /*defining default style is optional */
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "bla bla \nbla bla \nbla bla \nbla bla \nbla bla \nbla blabla bla \n"
                                                            " \nbla bla \nbla bla \nbla bla \nbla bla \nbla bla \nbla bla \n",
                                                    style: const TextStyle(
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
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == false) return;
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Close"))
                          ],
                          title: const Text("form content"),
                          content: const Text("we are good"),
                        ));
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 20,
                shadowColor: Colors.grey,
                minimumSize: const Size.fromHeight(48),
                backgroundColor: myColor,
              ),
              child: const Text("Register")),
          const SizedBox(height: 12),
          _buildGreyText("Or Login with"),
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
                  icon: Image.asset(
                "assets/socialIcons/github.png",
                width: 32,
                height: 32,
              )),
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
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
                  })
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
