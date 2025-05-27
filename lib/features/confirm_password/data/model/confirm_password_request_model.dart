class ConfirmPasswordRequestModel {
  String? phone;
  String? password;
  String? confirmPassword;

  ConfirmPasswordRequestModel({this.phone,this.confirmPassword, this.password});

  ConfirmPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    confirmPassword = json['new_password_confirmation'];
    password = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['new_password_confirmation'] = confirmPassword;
    data['new_password'] = password;
    return data;
  }
}
