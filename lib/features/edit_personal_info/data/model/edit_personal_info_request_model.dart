class EditPersonalInfoRequestModel {
  final String name;
  final String email;

  EditPersonalInfoRequestModel({
    required this.name,
    required this.email,
  });

  factory EditPersonalInfoRequestModel.fromJson(Map<String, dynamic> json) {
    return EditPersonalInfoRequestModel(
      name: json['name'],
      email: json['email'],
    );
  }

  // Method to convert a User to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
