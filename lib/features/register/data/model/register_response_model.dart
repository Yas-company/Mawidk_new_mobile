import 'dart:convert';

class RegisterResponseModel {
  RegisterModel? model;
  RegisterResponseModel({
    this.model,
  });

  RegisterResponseModel copyWith({
    RegisterModel? model,
  }) {
    return RegisterResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.toMap(),
    };
  }

  RegisterResponseModel fromMap(Map<String, dynamic> map) {
    return RegisterResponseModel(
      model: map['model'] != null
          ? RegisterModel.fromMap(map['model'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  RegisterResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponseModel(model: $model)';

  @override
  bool operator ==(covariant RegisterResponseModel other) {
    if (identical(this, other)) return true;

    return other.model == model;
  }

  @override
  int get hashCode => model.hashCode;
}

class RegisterModel {
  String? name;
  String? phone;
  num? profileCompletionPercentage;

  RegisterModel({
    this.name,
    this.phone,
    this.profileCompletionPercentage,
  });

  RegisterModel copyWith({
    String? name,
    String? phone,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'profile_completion_percentage': profileCompletionPercentage,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      profileCompletionPercentage: map['profile_completion_percentage'] != null ? map['profile_completion_percentage'] as num : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone:map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginModel(name: $name, phone: $phone)';

  @override
  bool operator ==(covariant RegisterModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
