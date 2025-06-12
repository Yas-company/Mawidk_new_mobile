class UpdateDiagnosisRequestModel {
  final String? description;
  final String? date;

  UpdateDiagnosisRequestModel({
    this.description,
    this.date,
  });

  factory UpdateDiagnosisRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateDiagnosisRequestModel(
      description: json['description'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'date': date,
    };
  }
}
