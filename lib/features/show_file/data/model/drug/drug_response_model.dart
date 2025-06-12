class DrugResponseModel {
  final List<DrugData>? model;

  DrugResponseModel({
    this.model,
  });

  DrugResponseModel fromMap(Map<String, dynamic> map) {
    return DrugResponseModel(
      model: map['model'] != null
          ? List<DrugData>.from(
        (map['model']).map<DrugData?>(
              (x) => DrugData().fromMap(x as Map<String, dynamic>),
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

class DrugData {
  final int? id;
  final String? name;
  final int? dosage;
  final int? frequency;
  final String? startDate;
  final String? instructions;

  DrugData({
    this.id,
    this.dosage,
    this.startDate,
    this.frequency,
    this.name,
    this.instructions,
  });

  DrugData fromMap(Map<String, dynamic> json) {
    return DrugData(
      id: json['id'] as int?,
      dosage: json['dosage'] as int?,
      frequency: json['frequency'] as int?,
      startDate: json['start_date'] as String?,
      name: json['name'] as String?,
      instructions: json['instructions'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dosage': dosage,
      'frequency': frequency,
      'name': name,
      'start_date': startDate,
      'instructions': instructions,
    };
  }
}

