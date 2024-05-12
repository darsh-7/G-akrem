import 'package:akrem/model/item.dart';

class ShoppingCartModel {
  late String id;
  late String name;
  late String image;
  late double price;
  late int quantity;

  ShoppingCartModel({required this.id, required this.image, required this.name, required this.price, required this.quantity});

  void setQty(int i) {
    if(i<1){
      quantity = 1;
    } else {
      quantity = i;
    }
  }
}

// List<ShoppingCartModel> shoppingCartData = [
//   ShoppingCartModel(
//     id: 1,
//     name: 'Panadol Advance 500mg',
//     image: 'https://dkud4u09qff41.cloudfront.net/Products/ac84b8ac-e0e8-45e8-827f-7c7a3b0c5aca.jpeg',
//     price: 8.6,
//     quantity: 2,
//   ),
//   ShoppingCartModel(
//     id: 2,
//     name: 'Aerius 5mg',
//     image: "https://dkud4u09qff41.cloudfront.net/Products/54f8c485-60da-43be-86f4-6a535bc6ef70.jpeg",
//     price: 11.5,
//     quantity: 1,
//   ),
//   ShoppingCartModel(
//     id: 3,
//     name: 'Viotic Ear Drops - 10 ML',
//     image: "https://dkud4u09qff41.cloudfront.net/Products/0558d4c8-1b83-4901-a147-32bbdd32edea.jpeg",
//     price: 11.46,
//     quantity: 1,
//   ),
// ];