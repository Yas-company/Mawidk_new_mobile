class MedicalHistoryResponseModel {
  final MedicalHistoryData? model;

  MedicalHistoryResponseModel({
    this.model,
  });

  MedicalHistoryResponseModel fromMap(Map<String, dynamic> json) {
    return MedicalHistoryResponseModel(
      model: json['model'] != null ? MedicalHistoryData().fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class MedicalHistoryData {
  int? id;
  String? familyDiseases;
  String? seriousHealthIssues;
  List<String>? chronicDiseases;
  int? smokingStatusCode;
  String? smokingStatus;
  int? exerciseFrequencyCode;
  String? exerciseFrequency;

  MedicalHistoryData({
    this.id,
    this.familyDiseases,
    this.seriousHealthIssues,
    this.chronicDiseases,
    this.smokingStatusCode,
    this.smokingStatus,
    this.exerciseFrequencyCode,
    this.exerciseFrequency,
  });

  MedicalHistoryData fromMap(Map<String, dynamic> json) {
    return MedicalHistoryData(
      id: json['id'],
      familyDiseases: json['family_diseases'],
      seriousHealthIssues: json['serious_health_issues'],
      chronicDiseases: (json['chronic_diseases'] as List?)?.map((e) => e.toString()).toList(),
      smokingStatusCode: json['smoking_status_code'],
      smokingStatus: json['smoking_status'],
      exerciseFrequencyCode: json['exercise_frequency_code'],
      exerciseFrequency: json['exercise_frequency'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'family_diseases': familyDiseases,
      'serious_health_issues': seriousHealthIssues,
      'chronic_diseases': chronicDiseases,
      'smoking_status_code': smokingStatusCode,
      'smoking_status': smokingStatus,
      'exercise_frequency_code': exerciseFrequencyCode,
      'exercise_frequency': exerciseFrequency,
    };
  }
}

