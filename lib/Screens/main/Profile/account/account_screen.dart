import 'package:akrem/Api/user_api.dart';
import 'package:akrem/Screens/login/login_page.dart';
import 'package:akrem/Screens/main/NavigationBar.dart';
import 'package:akrem/Screens/main/Profile/account/add_phone.dart';
import 'package:akrem/Screens/main/Profile/account/change_password.dart';
import 'package:akrem/Screens/main/Profile/account/edit_info.dart';
import 'package:akrem/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _FirstScreenState();
}

UserController userController = Get.find();

class _FirstScreenState extends State<AccountView> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Account',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userController.user.fName ?? "No Name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(userController.user.email ?? "No Email"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditView(
                                email: userController.user.email,
                                fName: userController.user.fName,
                                lName: userController.user.lName),
                          )).then((_) => setState(() {}));
                        },
                        style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 31, 94, 201)),
                        child: const Text('Edit info'),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey.withOpacity(0.5),
                thickness: 8,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Security Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Password'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '* * * * * * * * * * * * * * ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PasswordView(),
                          ));
                        },
                        style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 31, 94, 201)),
                        child: const Text('Change Password'),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey.withOpacity(0.5),
                thickness: 8,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        userController.user.phone == null
                            ? ""
                            : '*******${ userController.user.phone?.substring(userController.user.phone!.length - 3)} ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PhoneView(),
                          ));
                        },
                        style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 31, 94, 201)),
                        child:  Text(userController.user.phone == null
                            ? 'Add Phone Number'
                            : 'Change Phone Number'),
                      ),
                      const Text(
                        'This phone number is your primary phone number and is unique across akram',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 10,
                color: Colors.grey.withOpacity(0.5),
                thickness: 8,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account Deletion',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'We are sad to see you go, but hope to see you again!',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Close")),
                                TextButton(
                                    onPressed: () {
                                      UserAPI.deleteAccount();
                                      Get.back();
                                      Get.offAll(LoginPage());
                                    },
                                    child: const Text("Delete",
                                        style: TextStyle(
                                            color: Colors.redAccent)))
                              ],
                              title: const Text(
                                  "Are you sure 😢"),
                              content: Text(
                                  "Are you sure 😢 you want to delete your account, this action is not reversible"),
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
                                  "some thing went wrong try again later"),
                            ));
                          }
                        },
                        style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 208, 7, 7)),
                        child: const Text('Delete your account'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
