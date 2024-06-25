

class MarketContent {
  int? id;
  String? name;
  double? price;
  String? imagePath;
  int? totalQuantity;
  double? priceAfterDiscount;
  MarketContent({this.id, this.name, this.price, this.imagePath, this.totalQuantity, this.priceAfterDiscount});

  MarketContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imagePath = json['imagePath'];
    totalQuantity = json['totalQuantity'];
    priceAfterDiscount = json['priceAfterDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imagePath'] = this.imagePath;
    data['totalQuantity'] = this.totalQuantity;
    data['priceAfterDiscount'] = this.priceAfterDiscount;
    return data;
  }
}