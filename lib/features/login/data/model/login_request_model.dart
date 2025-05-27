class LoginRequestModel {
  String? phone;
  String? password;
  int? type;

  LoginRequestModel({this.phone, this.password,this.type});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = phone;
    data['password'] = password;
    data['type'] = type;
    return data;
  }
}
