class UserApiModel {
  Content? content;
  Null? error;
  bool? isSuccess;
  String? responseTime;

  UserApiModel({this.content, this.error, this.isSuccess, this.responseTime});

  UserApiModel.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    error = json['error'];
    isSuccess = json['isSuccess'];
    responseTime = json['responseTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['error'] = this.error;
    data['isSuccess'] = this.isSuccess;
    data['responseTime'] = this.responseTime;
    return data;
  }
}




class Content {
  String? token;
  String? expireOn;
  List<String>? roles;

  Content({this.token, this.expireOn, this.roles});

  Content.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expireOn = json['expireOn'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expireOn'] = this.expireOn;
    data['roles'] = this.roles;
    return data;
  }
}
