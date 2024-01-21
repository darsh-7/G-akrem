import 'package:akrem/Screens/main/Profile/setting_screen.dart';
import 'package:flutter/material.dart';


class PhoneView extends StatefulWidget {
  const PhoneView({super.key});

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(
                  MaterialPageRoute(
                    builder: (context) => const SettingsView(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text(
            'Add Phone',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Set up your primary phone number',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                'Please enter your mobile number, and we will send you a PIN',
                style: TextStyle(
                    color: Color.fromARGB(255, 53, 51, 51), fontSize: 16),
              )),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Enter Mobile Number',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {},
              child: const Text('CHANGE NUMBER'),
            )),
          ],
        ),
      ),
    );
  }
}
