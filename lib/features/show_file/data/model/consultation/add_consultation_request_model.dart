class AddConsultationRequestModel {
  int? patientId;
  String? mainComplaint;
  String? consultationDate;
  int? bloodPressureSystolic;
  int? bloodPressureDiastolic;
  int? pulseRate;
  int? bloodSugarLevel;
  double? temperature;
  String? clinicalExamination;
  String? nextFollowUpDate;
  String? notes;

  AddConsultationRequestModel({
    this.patientId,
    this.mainComplaint,
    this.consultationDate,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.pulseRate,
    this.bloodSugarLevel,
    this.temperature,
    this.clinicalExamination,
    this.nextFollowUpDate,
    this.notes,
  });

  AddConsultationRequestModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'] as int?;
    mainComplaint = json['main_complaint'] as String?;
    consultationDate = json['consultation_date'] as String?;
    bloodPressureSystolic = json['blood_pressure_systolic'] as int?;
    bloodPressureDiastolic = json['blood_pressure_diastolic'] as int?;
    pulseRate = json['pulse_rate'] as int?;
    bloodSugarLevel = json['blood_sugar_level'] as int?;
    temperature = (json['temperature'] as num?)?.toDouble();
    clinicalExamination = json['clinical_examination'] as String?;
    nextFollowUpDate = json['next_follow_up_date'] as String?;
    notes = json['notes'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      if (patientId != null) 'patient_id': patientId,
      if (mainComplaint != null) 'main_complaint': mainComplaint,
      if (consultationDate != null) 'consultation_date': consultationDate,
      if (bloodPressureSystolic != null) 'blood_pressure_systolic': bloodPressureSystolic,
      if (bloodPressureDiastolic != null) 'blood_pressure_diastolic': bloodPressureDiastolic,
      if (pulseRate != null) 'pulse_rate': pulseRate,
      if (bloodSugarLevel != null) 'blood_sugar_level': bloodSugarLevel,
      if (temperature != null) 'temperature': temperature,
      if (clinicalExamination != null) 'clinical_examination': clinicalExamination,
      if (nextFollowUpDate != null) 'next_follow_up_date': nextFollowUpDate,
      if (notes != null) 'notes': notes,
    };
  }
}
