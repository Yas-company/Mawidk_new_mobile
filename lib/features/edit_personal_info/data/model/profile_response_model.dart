class ProfileResponseModel {
  final ProfileData? model;

  ProfileResponseModel({
    this.model,
  });

  ProfileResponseModel fromMap(Map<String, dynamic> json) {
    return ProfileResponseModel(
      model: json['model'] != null ? ProfileData.fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class ProfileData {
  final String? name;
  final String? email;
  final String? avatar;
  final bool? isActive;

  ProfileData({
    this.isActive,
    this.name,
    this.email,
    this.avatar,
  });

  factory ProfileData.fromMap(Map<String, dynamic> json) {
    return ProfileData(
      isActive: json['is_active'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_active': isActive,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
