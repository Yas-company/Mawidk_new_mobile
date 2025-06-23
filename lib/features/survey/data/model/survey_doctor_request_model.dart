import 'dart:io';


import 'dart:convert';
import 'dart:io';

class SurveyDoctorRequestModel {
  int? specializationId;
  int? experience;
  int? licenseNumber;
  int? gender;
  int? type_of_doctor;
  String? about_doctor;
  List<File>? certificates;
  List<String>? certificateNames;

  SurveyDoctorRequestModel({
    this.experience,
    this.licenseNumber,
    this.specializationId,
    this.type_of_doctor,
    this.gender,
    this.about_doctor,
    this.certificates,
    this.certificateNames,
  });

  // Convert from JSON
  factory SurveyDoctorRequestModel.fromJson(Map<String, dynamic> json) {
    return SurveyDoctorRequestModel(
      about_doctor: json['about_doctor'],
      type_of_doctor: json['type_of_doctor'],
      specializationId: json['specializationId'],
      experience: json['experience'],
      licenseNumber: json['licenseNumber'],
      gender: json['gender'],
      certificates: (json['certificates'] as List<dynamic>?)
          ?.map((e) => File(e))
          .toList(),
      certificateNames: (json['certificateNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'about_doctor': about_doctor,
      'type_of_doctor': type_of_doctor,
      'specializationId': specializationId,
      'experience': experience,
      'licenseNumber': licenseNumber,
      'gender': gender,
      'certificates': certificates?.map((e) => e.path).toList(),
      'certificateNames': certificateNames,
    };
  }
}

