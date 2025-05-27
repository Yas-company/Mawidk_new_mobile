class ChangePasswordRequestModel {
  String? currentPassword;
  String? newPassword;
  String? newPasswordConfirmation;

  ChangePasswordRequestModel({this.currentPassword,this.newPassword, this.newPasswordConfirmation});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'];
    newPassword = json['new_password'];
    newPasswordConfirmation = json['new_password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_password'] = currentPassword;
    data['new_password'] = newPassword;
    data['new_password_confirmation'] = newPasswordConfirmation;
    return data;
  }
}
