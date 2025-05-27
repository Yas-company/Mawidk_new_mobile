class VerifyOtpRequestModel {
  String? phone;
  String? otp;

  VerifyOtpRequestModel({this.phone,this.otp});

  VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    return data;
  }
}
