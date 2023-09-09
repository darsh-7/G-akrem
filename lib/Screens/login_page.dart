import 'package:flutter/material.dart';

import 'package:akrem/widgets/input.dart';
import 'package:akrem/widgets/appbar.dart';
import 'package:akrem/widgets/scrollable_column.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage() : super();

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Login to your account"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Form(
          key: _formKey,
          child: ScrollableColumn(
            children: [
              SizedBox(height: 24),
              CustomInputField(
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                controller: _emailController,
                validator: Validator.validateEmail,
                label: "Email" ,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(320),
                ],
              ),
              SizedBox(height: 24),
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
              SizedBox(height: 24),
              CustomCheckbox(
                labelText: "Remember me",
                value: _rememberMeChecked,
                onChanged: (checked) =>
                    setState(() => _rememberMeChecked = checked ?? false),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () =>
                  {Navigator.of(context).pushNamed("/map")},

                  // onPressed: () {
                  //   if (_formKey.currentState?.validate() == false) return;
                  //   showDialog(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //             actions: [
                  //               TextButton(
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                   child: const Text("Close"))
                  //             ],
                  //             title: const Text("form content"),
                  //             content: Text("we are good"),
                  //           ));
                  // },
                  child: const Text("Login")),
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Don't have an account",
                    style: TextStyle(
                      color: Color(0xFFb8b8b8),
                    ),
                  ),
                  TextButton(
                    child: Text("Register"),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed("/register")},
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
