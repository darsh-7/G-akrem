import 'package:akrem/Screens/empty_items.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
