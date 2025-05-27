class DoctorProfileStatusResponseModel {
  DoctorProfileStatusModel? model;

  DoctorProfileStatusResponseModel({this.model});

  DoctorProfileStatusResponseModel fromMap(Map<String, dynamic> json) {
    model = json['model'] != null ? DoctorProfileStatusModel().fromMap(json['model']) : null;
    return DoctorProfileStatusResponseModel(model:model);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.toMap();
    }
    return data;
  }
}

class DoctorProfileStatusModel {
  int? id;
  int? isActive;
  int? documentVerified;
  int? academicQualificationVerified;
  int? licenseVerified;
  String? dateOfApplication;

  DoctorProfileStatusModel(
      {this.id,
        this.isActive,
        this.documentVerified,
        this.academicQualificationVerified,
        this.licenseVerified,
        this.dateOfApplication});

  DoctorProfileStatusModel fromMap(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    documentVerified = json['document_verified'];
    academicQualificationVerified = json['academic_qualification_verified'];
    licenseVerified = json['license_verified'];
    dateOfApplication = json['date_of_application'];
    return DoctorProfileStatusModel(id:id,isActive: isActive,
        academicQualificationVerified: academicQualificationVerified,
    dateOfApplication: dateOfApplication,documentVerified: documentVerified,licenseVerified: licenseVerified);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_active'] = isActive;
    data['document_verified'] = documentVerified;
    data['academic_qualification_verified'] = academicQualificationVerified;
    data['license_verified'] = licenseVerified;
    data['date_of_application'] = dateOfApplication;
    return data;
  }
}