class AddDrugRequestModel {
  int? patientId;
  String? name;
  String? instructions;
  int? dosage;
  int? frequency;
  String? startDate;

  AddDrugRequestModel({
    this.patientId,
    this.name,
    this.instructions,
    this.dosage,
    this.frequency,
    this.startDate,
  });

  AddDrugRequestModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'] as int?;
    name = json['name'] as String?;
    instructions = json['instructions'] as String?;
    dosage = json['dosage'] as int?;
    frequency = json['frequency'] as int?;
    startDate = json['start_date'] as String?;
    // startDate = json['start_date'] != null
    //     ? DateTime.tryParse(json['start_date'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'name': name,
      'instructions': instructions,
      'dosage': dosage,
      'frequency': frequency,
      // 'start_date': startDate?.toIso8601String(),
      'start_date': startDate,
    };
  }
}
