class RegisterRequestModel {
  String? name;
  String? countryCode;
  String? phone;
  String? password;
  int? type;

  RegisterRequestModel(
      {this.name, this.countryCode, this.phone, this.password, this.type});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['type'] = this.type;
    return data;
  }
}