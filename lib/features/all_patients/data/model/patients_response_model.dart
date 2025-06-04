import 'dart:convert';
class PatientsResponseModel {
  List<PatientData>? model;

  PatientsResponseModel({
    this.model,
  });

  PatientsResponseModel copyWith({
    List<PatientData>? model,
  }) {
    return PatientsResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  PatientsResponseModel fromMap(Map<String, dynamic> map) {
    return PatientsResponseModel(
      model: map['model'] != null
          ? List<PatientData>.from(
        (map['model']).map<PatientData?>(
              (x) => PatientData.fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  PatientsResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}


class PatientData {
  final int? id;
  final String? name;
  final String? photo;
  final String? lastAppointmentDate;


  PatientData({
    this.id,
    this.name,
    this.photo,
    this.lastAppointmentDate,
  });

  factory PatientData.fromMap(Map<String, dynamic> json) {
    return PatientData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      lastAppointmentDate: json['last_appointment_date'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'last_appointment_date': lastAppointmentDate,
    };
  }
}
