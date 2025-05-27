class PatientSurveyRequestModel {
  int? gender;
  int? age;
  int? weight;
  int? height;
  int? generalHealth;
  List<String>? dailyMedications;
  List<String>? allergies;
  List<String>? infectiousDiseases;
  List<int>? chronicDiseaseIds;
  int? exerciseFrequency;
  int? smokingStatus;
  bool? sleepProblems;
  List<String>? familyDiseases;
  List<String>? seriousHealthIssues;
  List<String>? medicalCheckups;
  int? consultationPreference;
  int? doctorLocationPreference;
  bool? wantsNotifications;
  bool? wantsFollowUp;

  PatientSurveyRequestModel({
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.generalHealth,
    this.dailyMedications,
    this.allergies,
    this.infectiousDiseases,
    this.chronicDiseaseIds,
    this.exerciseFrequency,
    this.smokingStatus,
    this.sleepProblems,
    this.familyDiseases,
    this.seriousHealthIssues,
    this.medicalCheckups,
    this.consultationPreference,
    this.doctorLocationPreference,
    this.wantsNotifications,
    this.wantsFollowUp,
  });

  factory PatientSurveyRequestModel.fromJson(Map<String, dynamic> json) {
    return PatientSurveyRequestModel(
      gender: json['gender'],
      age: json['age'],
      weight: json['weight'],
      height: json['height'],
      generalHealth: json['general_health'],
      dailyMedications: (json['daily_medications'] as List?)?.cast<String>(),
      allergies: (json['allergies'] as List?)?.cast<String>(),
      infectiousDiseases: (json['infectious_diseases'] as List?)?.cast<String>(),
      chronicDiseaseIds: (json['chronic_disease_ids'] as List?)?.cast<int>(),
      exerciseFrequency: json['exercise_frequency'],
      smokingStatus: json['smoking_status'],
      sleepProblems: json['sleep_problems'],
      familyDiseases: (json['family_diseases'] as List?)?.cast<String>(),
      seriousHealthIssues: (json['serious_health_issues'] as List?)?.cast<String>(),
      medicalCheckups: (json['medical_checkups'] as List?)?.cast<String>(),
      consultationPreference: json['consultation_preference'],
      doctorLocationPreference: json['doctor_location_preference'],
      wantsNotifications: json['wants_notifications'],
      wantsFollowUp: json['wants_follow_up'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age': age,
      'weight': weight,
      'height': height,
      'general_health': generalHealth,
      'daily_medications': dailyMedications,
      'allergies': allergies,
      'infectious_diseases': infectiousDiseases,
      'chronic_disease_ids': chronicDiseaseIds,
      'exercise_frequency': exerciseFrequency,
      'smoking_status': smokingStatus,
      'sleep_problems': sleepProblems,
      'family_diseases': familyDiseases,
      'serious_health_issues': seriousHealthIssues,
      'medical_checkups': medicalCheckups,
      'consultation_preference': consultationPreference,
      'doctor_location_preference': doctorLocationPreference,
      'wants_notifications': wantsNotifications,
      'wants_follow_up': wantsFollowUp,
    };
  }
}
