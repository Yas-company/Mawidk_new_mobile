import 'dart:io';


import 'dart:convert';
import 'dart:io';

class SurveyDoctorRequestModel {
  int? specializationId;
  int? experience;
  int? licenseNumber;
  int? gender;
  List<File>? certificates;
  List<String>? certificateNames;

  SurveyDoctorRequestModel({
    this.experience,
    this.licenseNumber,
    this.specializationId,
    this.gender,
    this.certificates,
    this.certificateNames,
  });

  // Convert from JSON
  factory SurveyDoctorRequestModel.fromJson(Map<String, dynamic> json) {
    return SurveyDoctorRequestModel(
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
      'specializationId': specializationId,
      'experience': experience,
      'licenseNumber': licenseNumber,
      'gender': gender,
      'certificates': certificates?.map((e) => e.path).toList(),
      'certificateNames': certificateNames,
    };
  }
}

