class ContactUsRequestModel {
  String? phone;
  String? email;
  String? message;

  ContactUsRequestModel({this.phone, this.email, this.message});

  // Create an instance from JSON
  factory ContactUsRequestModel.fromJson(Map<String, dynamic> json) {
    return ContactUsRequestModel(
      phone: json['phone'],
      email: json['email'],
      message: json['message'],
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'message': message,
    };
  }
}
