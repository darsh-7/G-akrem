import 'package:akrem/Screens/add_items.dart';
import 'package:akrem/Screens/home_screen.dart';
import 'package:akrem/Screens/profle_Screen.dart';
import 'package:akrem/constants/app_colors.dart';
import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationBar].

// void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  Image image = Image.asset(
    AppImages.profileIcon,
  );
  var radius = const Radius.circular(10);
// @override
  // void initState() {
  // showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Close"))
  //       ],
  //       title: const Text("Welcome, Admin, to Akram "),
  //       content: Text("we are good"),
  //     ));
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          shadowColor: Colors.red,
          backgroundColor: AppColors.bar,
          indicatorColor: Colors.transparent,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: AppColors.mainColor,
                  ),
                  child: const Icon(Icons
                      .home_outlined) //Image.asset(AppImages.boxIcon,scale: 6),
              ),
              icon: const Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.add_box_rounded),
              selectedIcon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: AppColors.mainColor,
                  ),
                  child: const Icon(Icons
                      .add_box_rounded) //Image.asset(AppImages.boxIcon,scale: 6),
              ),
              label: 'Order',
            ),
            NavigationDestination(
              //selectedIcon: Image.asset("icons/icon-profile-circle.png"),
              selectedIcon: CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.mainColor,
                child: Padding(
                  padding: const EdgeInsets.all(4), // Border radius
                  child: ClipOval(child: image),
                ),
              ),

              icon: Container(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: image,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
        body: <Widget>[
          Home(),
          const ItemsScreen(),
          const ProfileScreen(),
        ][currentPageIndex],
    );
  }
}
