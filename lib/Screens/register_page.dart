//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:akrem/widgets/input.dart';
import 'package:akrem/widgets/appbar.dart';
import 'package:akrem/widgets/scrollable_column.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage() : super();
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _agreeWithTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Register new account"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Form(
          key: _formKey,
          child: ScrollableColumn(
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    width: 180,
                  ),
                  const Spacer(),
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
                    width: 180,
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
                label: "Password" ,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
              ),
              const SizedBox(height: 24),
              CustomInputField(
                keyboardType: TextInputType.visiblePassword,
                hintText: "Password Confirmation",
                label: "Password Confirmation" ,

                obscureText: true,
                controller: _passwordConfirmationController,
                validator: (String? password) {
                  if (password == null) {
                    return null;
                  }
                  if (password != _passwordConfirmationController.value.text) {
                    return "Password is not confirmed";
                  }
                },              ),
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
                        print("// Terms & Conditions");
                      },
                    ),
                  ],
                ),
                value: _agreeWithTermsAndConditions,
                onChanged: (checked) => setState(() => _agreeWithTermsAndConditions = checked ?? false),
              ),
              const SizedBox(height: 24),
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
                  child: const Text("Reglster")),
              Expanded(
                child: Container(),
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
                      Navigator.of(context).pushNamed("/login")
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
