import 'dart:convert';
class DoctorsForPatientResponseModel {
  List<DoctorModel>? model;

  DoctorsForPatientResponseModel({
    this.model,
  });

  DoctorsForPatientResponseModel copyWith({
    List<DoctorModel>? model,
  }) {
    return DoctorsForPatientResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  DoctorsForPatientResponseModel fromMap(Map<String, dynamic> map) {
    return DoctorsForPatientResponseModel(
      model: map['model'] != null
          ? List<DoctorModel>.from(
        (map['model']).map<DoctorModel?>(
              (x) => DoctorModel.fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  DoctorsForPatientResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}


class DoctorModel {
  final int? id;
  final String? name;
  final String? image;
  final String? specialization;
  final int? experience;
  final String? gender;
  final String? licenseNumber;
  final bool? isMatched;

  DoctorModel({
    this.id,
    this.name,
    this.image,
    this.specialization,
    this.experience,
    this.gender,
    this.licenseNumber,
    this.isMatched,
  });

   factory DoctorModel.fromMap(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      specialization: json['specialization'] as String?,
      experience: json['experience'] as int?,
      gender: json['gender'] as String?,
      licenseNumber: json['license_number'] as String?,
      isMatched: json['is_matched'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'specialization': specialization,
      'experience': experience,
      'gender': gender,
      'license_number': licenseNumber,
      'is_matched': isMatched,
    };
  }
}
