import 'package:akrem/widgets/scrollable_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomAppBar(title: "Register new account"),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: ScrollableColumn(children: [
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),
              SizedBox(height: 40),
              Text("data"),

            ])));

    // return CupertinoTabScaffold(
    //     tabBar: CupertinoTabBar(
    //       items: const [
    //         BottomNavigationBarItem(
    //             icon: Icon(CupertinoIcons.home),
    //             label: "Home",
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(CupertinoIcons.add),
    //           label: "add",
    //         ),
    //
    //       ],
    //     ),
    //     tabBuilder:(context,i) {
    //       return const Text("data");
    //     }
    // );
  }
}
