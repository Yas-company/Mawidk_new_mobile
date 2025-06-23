import 'dart:convert';

class LoginResponseModel {
  LoginModel? model;
  LoginResponseModel({
    this.model,
  });

  LoginResponseModel copyWith({
    LoginModel? model,
  }) {
    return LoginResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.toMap(),
    };
  }

  LoginResponseModel fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      model: map['model'] != null
          ? LoginModel.fromMap(map['model'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  LoginResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponseModel(model: $model)';

  @override
  bool operator ==(covariant LoginResponseModel other) {
    if (identical(this, other)) return true;

    return other.model == model;
  }

  @override
  int get hashCode => model.hashCode;
}

class LoginModel {
  int? id;
  String? name;
  String? phone;
  num? profileCompletionPercentage;
  bool? surveyStatus;
  bool? isVerified;
  String? accessToken;
  String? refreshToken;

  LoginModel({
    this.id,
    this.name,
    this.phone,
    this.accessToken,
    this.refreshToken,
    this.profileCompletionPercentage,
    this.isVerified,
    this.surveyStatus,
  });

  LoginModel copyWith({
    int? id,
    String? name,
    String? phone,
    bool? surveyStatus,
    bool? isVerified,
    String? accessToken,
    String? refreshToken
  }) {
    return LoginModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      surveyStatus: surveyStatus ?? this.surveyStatus,
      accessToken: accessToken ?? this.accessToken,
      isVerified: isVerified ?? this.isVerified,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'refreshToken': refreshToken,
      'profile_completion_percentage': profileCompletionPercentage,
      'accessToken': accessToken,
      'is_verified': isVerified,
      'survey_status': surveyStatus,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone:map['phone'] != null ? map['phone'] as String : null,
      profileCompletionPercentage:map['profile_completion_percentage'] != null ?
      map['profile_completion_percentage'] as num : null,
      accessToken:map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken:map['refreshToken'] != null ? map['refreshToken'] as String : null,
      surveyStatus:map['survey_status'] != null ? map['survey_status'] as bool : null,
      isVerified:map['is_verified'] != null ? map['is_verified'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
  //
  // @override
  // String toString() => 'LoginModel(name: $name, phone: $phone)';

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
