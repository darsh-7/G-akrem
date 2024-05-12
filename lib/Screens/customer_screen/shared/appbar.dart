import 'package:akrem/Screens/customer_screen/Home/basket/cart_page.dart';
import 'package:akrem/Screens/customer_screen/provider/cart.dart';
import 'package:akrem/Screens/customer_screen/shared/cart_buttom.dart';
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
