

class OrdeHistory {
  int? id;
  int? orderStatuses;
  String? arrivedDate;
  String? latitude;
  String? longitude;
  String? phoneNumber;
  String? address;
  String? clientId;
  int? areaId;
  int? areaName;
  int? orderTypes;
  String? createdOn;

  OrdeHistory(
      {this.id,
        this.orderStatuses,
        this.arrivedDate,
        this.latitude,
        this.longitude,
        this.phoneNumber,
        this.address,
        this.clientId,
        this.areaId,
        this.areaName,
        this.orderTypes,
        this.createdOn});

  OrdeHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatuses = json['orderStatuses'];
    arrivedDate = json['arrivedDate'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    clientId = json['clientId'];
    areaId = json['areaId'];
    areaName = json['areaName'];
    orderTypes = json['orderTypes'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderStatuses'] = this.orderStatuses;
    data['arrivedDate'] = this.arrivedDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['clientId'] = this.clientId;
    data['areaId'] = this.areaId;
    data['areaName'] = this.areaName;
    data['orderTypes'] = this.orderTypes;
    data['createdOn'] = this.createdOn;
    return data;
  }
}