class AddDiagnosisRequestModel {
  int? patientId;
  String? diagnosis;
  String? description;
  int? status; // 0 => unstable, 1 => stable
  String? date;

  AddDiagnosisRequestModel({
    this.patientId,
    this.diagnosis,
    this.description,
    this.status,
    this.date,
  });

  factory AddDiagnosisRequestModel.fromJson(Map<String, dynamic> json) {
    return AddDiagnosisRequestModel(
      patientId: json['patient_id'],
      diagnosis: json['diagnosis'],
      description: json['description'],
      status: json['status'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'diagnosis': diagnosis,
      'description': description,
      'status': status,
      'date': date,
    };
  }
}
