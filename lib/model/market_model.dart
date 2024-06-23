

class MarketContent {
  int? id;
  String? name;
  double? price;
  String? imagePath;
  int? totalQuantity;

  MarketContent({this.id, this.name, this.price, this.imagePath, this.totalQuantity});

  MarketContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imagePath = json['imagePath'];
    totalQuantity = json['totalQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imagePath'] = this.imagePath;
    data['totalQuantity'] = this.totalQuantity;
    return data;
  }
}