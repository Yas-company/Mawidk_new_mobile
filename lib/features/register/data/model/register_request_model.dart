class RegisterRequestModel {
  String? name;
  String? countryCode;
  String? phone;
  String? password;
  String? gender;
  String? email;
  int? type;

  RegisterRequestModel(
      {this.name, this.countryCode, this.phone, this.password, this.type,this.email});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    password = json['password'];
    gender = json['gender'];
    type = json['type'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['email'] = this.email;
    return data;
  }
}