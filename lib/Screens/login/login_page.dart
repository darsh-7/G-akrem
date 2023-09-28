import 'package:akrem/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:akrem/widgets/input.dart';
import 'package:akrem/widgets/appbar.dart';
import 'package:akrem/widgets/scrollable_column.dart';
import 'package:akrem/services/validator.dart';
import 'package:flutter/scheduler.dart';
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
      body:

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Form(
          key: _formKey,
          child: ScrollableColumn(
            children: [
              const SizedBox(height: 24),
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
              CustomCheckbox(
                labelText: "Remember me",
                value: _rememberMeChecked,
                onChanged: (checked) =>
                    setState(() => _rememberMeChecked = checked ?? false),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  // onPressed:
                  // {
                  // SchedulerBinding.instance.addPostFrameCallback((_) {
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  // '/main', (Route<dynamic> route) => false);
                  // })
                  //                  },
                  onPressed: () {
                    if (_formKey.currentState?.validate() == false) return;

                    if(_emailController.value.toString() == "admin@gmail.com" && _passwordController.value.toString() == "admin") {
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
                            title: const Text("Data not valued"),
                            content: const Text("Pls try again using different email or password"),
                          ));
                      return;
                    }

                    SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                    '/main', (Route<dynamic> route) => false);
                    });


                  },
                  child: const Text("Login")),
              Container(
                margin: EdgeInsets.all(30),
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: RawMaterialButton(
                    child: Text("Skip",style: TextStyle(fontSize: 20),), onPressed: ()  {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/main', (Route<dynamic> route) => false);
                  });
                }),
              ),
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
                      color: AppColors.mainColor,
                    ),
                  ),
                  TextButton(
                    child: const Text("Register"),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed("/register")},
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
