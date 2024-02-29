import 'package:akrem/Screens/customer_screen/Home/basket/check_out.dart';
import 'package:akrem/Screens/customer_screen/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductsAndPrice extends StatefulWidget {
  const ProductsAndPrice({super.key});

  @override
  State<ProductsAndPrice> createState() => _ProductsAndPriceState();
}

class _ProductsAndPriceState extends State<ProductsAndPrice> {
  @override
  Widget build(BuildContext context) {
    final textt = Provider.of<Cart>(context);
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 27,
              height: 18,
              decoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
              child: Center(
                  child: Text(
                "${textt.selectedProducts.length}",
                style: const TextStyle(color: Colors.black),
              )),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckView()));
                },
                icon: const Icon(Icons.add_shopping_cart)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            '\$ ${textt.price}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        )
      ],
    );
  }
}
