import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier{
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  Category? category;

  Products(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.images,
        this.creationAt,
        this.updatedAt,
        this.category});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  static List<Products> productsFromSnapshot(List productSnaphot) {
     print("data ${productSnaphot[0]}");
    return productSnaphot.map((data) {
      return Products.fromJson(data);
    }).toList();
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? creationAt;
  String? updatedAt;

  Category({this.id, this.name, this.image, this.creationAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }
}