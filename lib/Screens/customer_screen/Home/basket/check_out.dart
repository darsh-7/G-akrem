import 'package:akrem/Screens/customer_screen/Home/basket/home_view.dart';
import 'package:akrem/Screens/customer_screen/provider/cart.dart';
import 'package:akrem/Screens/customer_screen/shared/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckView extends StatefulWidget {
  const CheckView({super.key});

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  @override
  Widget build(BuildContext context) {
    final textt = Provider.of<Cart>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => const HomeView()));
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('Checkout Screen'),
          actions: const [
            ProductsAndPrice(),
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 600,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: textt.selectedProducts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        subtitle:
                            Text('${textt.selectedProducts[index].price}'),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(textt.selectedProducts[index].imgPath),
                        ),
                        title: Text(textt.selectedProducts[index].name),
                        trailing: IconButton(
                            onPressed: () {
                              textt.delete(textt.selectedProducts[index]);
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
              child: Text(
                'pay \$${textt.price}',
                style: const TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
