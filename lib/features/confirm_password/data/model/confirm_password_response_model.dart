import 'dart:convert';

class ConfirmPasswordResponseModel {
  ConfirmPasswordModel? model;
  ConfirmPasswordResponseModel({
    this.model,
  });

  ConfirmPasswordResponseModel copyWith({
    ConfirmPasswordModel? model,
  }) {
    return ConfirmPasswordResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.toMap(),
    };
  }

  ConfirmPasswordResponseModel fromMap(Map<String, dynamic> map) {
    return ConfirmPasswordResponseModel(
      model: map['model'] != null
          ? ConfirmPasswordModel.fromMap(map['model'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  ConfirmPasswordResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginResponseModel(model: $model)';

  @override
  bool operator ==(covariant ConfirmPasswordResponseModel other) {
    if (identical(this, other)) return true;

    return other.model == model;
  }

  @override
  int get hashCode => model.hashCode;
}

class ConfirmPasswordModel {
  String? name;
  String? phone;

  ConfirmPasswordModel({
    this.name,
    this.phone,
  });

  ConfirmPasswordModel copyWith({
    String? name,
    String? phone,
  }) {
    return ConfirmPasswordModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
    };
  }

  factory ConfirmPasswordModel.fromMap(Map<String, dynamic> map) {
    return ConfirmPasswordModel(
      name: map['name'] != null ? map['name'] as String : null,
      phone:map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmPasswordModel.fromJson(String source) =>
      ConfirmPasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginModel(name: $name, phone: $phone)';

  @override
  bool operator ==(covariant ConfirmPasswordModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}
