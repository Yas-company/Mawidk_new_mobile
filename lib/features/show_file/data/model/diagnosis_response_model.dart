class DiagnosisResponseModel {
  final List<DiagnosisData>? model;

  DiagnosisResponseModel({
    this.model,
  });

  DiagnosisResponseModel fromMap(Map<String, dynamic> map) {
    return DiagnosisResponseModel(
      model: map['model'] != null
          ? List<DiagnosisData>.from(
        (map['model']).map<DiagnosisData?>(
              (x) => DiagnosisData().fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }
}

class DiagnosisData {
  final int? id;
  final String? status;
  final String? diagnosis;
  final String? description;
  final String? date;

  DiagnosisData({
    this.id,
    this.diagnosis,
    this.date,
    this.description,
    this.status,
  });

  DiagnosisData fromMap(Map<String, dynamic> json) {
    return DiagnosisData(
      id: json['id'] as int?,
      diagnosis: json['diagnosis'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'diagnosis': diagnosis,
      'description': description,
      'status': status,
      'date': date,
    };
  }
}

