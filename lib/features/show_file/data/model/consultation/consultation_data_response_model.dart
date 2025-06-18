class ConsultationDataResponseModel {
  final ConsultationItemModel? model;

  ConsultationDataResponseModel({
    this.model,
  });

  ConsultationDataResponseModel fromMap(Map<String, dynamic> json) {
    return ConsultationDataResponseModel(
      model: json['model'] != null ? ConsultationItemModel().fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class ConsultationItemModel {
  final int? id;
  final String? main_complaint;
  final String? consultation_date;
  final String? clinical_examination;
  final String? next_follow_up_date;
  final String? notes;
  final int? blood_pressure_systolic;
  final int? blood_pressure_diastolic;
  final dynamic pulse_rate;
  final dynamic blood_sugar_level;
  final dynamic temperature;



  ConsultationItemModel({
    this.id,
    this.main_complaint,
    this.consultation_date,
    this.blood_pressure_systolic,
    this.notes,
    this.next_follow_up_date,
    this.blood_pressure_diastolic,
    this.pulse_rate,
    this.blood_sugar_level,
    this.temperature,
    this.clinical_examination,
  });

  ConsultationItemModel fromMap(Map<String, dynamic> json) {
    return ConsultationItemModel(
      id: json['id'] as int?,
      main_complaint: json['main_complaint'] as String?,
      next_follow_up_date: json['next_follow_up_date'] as String?,
      notes: json['notes'] as String?,
      consultation_date: json['consultation_date'] as String?,
      clinical_examination: json['clinical_examination'] as String?,
      blood_pressure_systolic: json['blood_pressure_systolic'] as int?,
      blood_pressure_diastolic: json['blood_pressure_diastolic'] as int?,
      pulse_rate: json['pulse_rate'] as dynamic,
      blood_sugar_level: json['blood_sugar_level'] as dynamic,
      temperature: json['temperature'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main_complaint': main_complaint,
      'next_follow_up_date': next_follow_up_date,
      'consultation_date': consultation_date,
      'blood_pressure_systolic': blood_pressure_systolic,
      'blood_pressure_diastolic': blood_pressure_diastolic,
      'pulse_rate': pulse_rate,
      'blood_sugar_level': blood_sugar_level,
      'temperature': temperature,
      'clinical_examination': clinical_examination,
      'notes': notes,
    };
  }
}

