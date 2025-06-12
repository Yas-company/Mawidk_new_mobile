class UpdateDrugRequestModel {
  String? name;
  String? instructions;
  int? dosage;

  UpdateDrugRequestModel({
    this.name,
    this.instructions,
    this.dosage,
  });

  UpdateDrugRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    instructions = json['instructions'] as String?;
    dosage = json['dosage'] as int?;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'instructions': instructions,
      'dosage': dosage,
    };
  }
}
