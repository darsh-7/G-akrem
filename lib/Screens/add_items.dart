import 'package:akrem/Screens/empty_items.dart';
import 'package:akrem/widgets/appbarr.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Donation items"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //final manager = Provider.of<GroceryManager>(context, listen: false);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => GroceryItemScreen(
          //       onCreate: (item) {
          //         //manager.addItem(item);
          //         Navigator.pop(context);
          //       },
          //       onUpdate: (item) {},
          //     ),
          //   ),
          // );
        },
      ),
      body: EmptyItemsScreen(),
    );
  }

// Widget buildItemsScreen() {
//   return Consumer<GroceryManager>(builder: (context, manager, child) {
//     if (manager.groceryItem.isNotEmpty) {
//       return GroceryListScreen(manager: manager);
//     } else {
//       return const EmptyItemsScreen();
//     }
//   });
// }
}

class Item {
  final Image img;
  final String title;
  final int? bar;
  final int? pills;
  DateTime? date;

  //String formattedDate = DateFormat('d MMMM yyyy', 'fr_FR').format(now);
  Item({
    required this.img,
    required this.title,
    this.bar,
    this.pills,
    this.date,
  });
}
