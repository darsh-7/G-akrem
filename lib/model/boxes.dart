
class BoxContent {
  int? id;
  double? latitude;
  double? longitude;
  int? capacity;
  int? branchId;
  String? branch;
  String? branchAddress;
  String? branchPhoneNumber;
  String? branchImagePath;
  bool? isDeleted;
  String? createdOn;
  String? createdById;

  BoxContent(
      {this.id,
        this.latitude,
        this.longitude,
        this.capacity,
        this.branchId,
        this.branch,
        this.branchAddress,
        this.branchPhoneNumber,
        this.branchImagePath,
        this.isDeleted,
        this.createdOn,
        this.createdById,});

  BoxContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude =  double.parse(json['latitude']??"0")  ;
    longitude =  double.parse(json['longitude']??"0");
    capacity = json['capacity'];
    branchId = json['branchId'];
    branch = json['branchName'];
    branchAddress = json['branchAddress'];
    branchPhoneNumber = json['branchPhoneNumber'];
    branchImagePath = json['branchImagePath'];
    isDeleted = json['isDeleted'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['capacity'] = this.capacity;
    data['branchId'] = this.branchId;
    data['branch'] = this.branch;
    data['isDeleted'] = this.isDeleted;
    data['createdOn'] = this.createdOn;
    data['createdById'] = this.createdById;
    return data;
  }
}