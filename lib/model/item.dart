class Product {
  String imgPath;
  double price;
  String name;
  Product({required this.imgPath, required this.price, required this.name});
}

final List<Product> items = [
  Product(name: 'product 1', imgPath: 'assets/1.jpg', price: 12.99),
  Product(name: 'product 2', imgPath: 'assets/2.jpg', price: 14.78),
  Product(name: 'product 3', imgPath: 'assets/3.jpg', price: 13.98),
  Product(name: 'product 4', imgPath: 'assets/4.jpg', price: 18.80),
  Product(name: 'product 5', imgPath: 'assets/5.jpg', price: 8.99),
  Product(name: 'product 6', imgPath: 'assets/6.jpg', price: 6.98),
  Product(name: 'product 7', imgPath: 'assets/7.jpg', price: 7.77),
  Product(name: 'product 8', imgPath: 'assets/8.jpg', price: 9.99),
];
