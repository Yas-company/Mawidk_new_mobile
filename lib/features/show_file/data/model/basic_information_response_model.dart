class BasicInformationResponseModel {
  final BasicInformationData? model;

  BasicInformationResponseModel({
    this.model,
  });

  BasicInformationResponseModel fromMap(Map<String, dynamic> json) {
    return BasicInformationResponseModel(
      model: json['model'] != null ? BasicInformationData.fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class BasicInformationData {
  final int? id;
  final String? name;
  final String? photo;
  final String? email;
  final String? phone;
  final num? age;
  final num? gender;
  final num? weight;
  final String? bloodType;
  final String? birthDate;
  final String? allergies;
  final String? address;

  BasicInformationData({
    this.id,
    this.name,
    this.photo,
    this.email,
    this.phone,
    this.age,
    this.gender,
    this.bloodType,
    this.weight,
    this.birthDate,
    this.allergies,
    this.address,
  });

  factory BasicInformationData.fromMap(Map<String, dynamic> json) {
    return BasicInformationData(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      phone: json['phone'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      bloodType: json['blood_type'],
      birthDate: json['birth_date'],
      weight: json['weight'],
      allergies: json['allergies'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'phone': phone,
      'email': email,
      'age': age,
      'gender': gender,
      'blood_type': bloodType,
      'birth_date': birthDate,
      'weight': weight,
      'allergies': allergies,
      'address': address,
    };
  }
}
