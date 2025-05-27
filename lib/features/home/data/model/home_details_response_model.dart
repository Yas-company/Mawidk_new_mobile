class DoctorHomeDetailsResponseModel {
  Model? model;

  DoctorHomeDetailsResponseModel({this.model});

  DoctorHomeDetailsResponseModel fromMap(Map<String, dynamic> json) {
    model = json['model'] != null ? Model().fromMap(json['model']) : null;
    return DoctorHomeDetailsResponseModel(model:model);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.toMap();
    }
    return data;
  }
}

class Model {
  int? clinicAppointments;
  int? onlineAppointments;
  int? followUpAppointments;
  int? homeVisitAppointments;
  int? totalPatients;
  int? newPatients;
  int? averageRating;
  dynamic upcomingAppointment;

  Model(
      {this.clinicAppointments,
        this.onlineAppointments,
        this.followUpAppointments,
        this.homeVisitAppointments,
        this.totalPatients,
        this.newPatients,
        this.averageRating,
        this.upcomingAppointment});

  Model fromMap(Map<String, dynamic> json) {
    clinicAppointments = json['clinic_appointments'];
    onlineAppointments = json['online_appointments'];
    followUpAppointments = json['follow_up_appointments'];
    homeVisitAppointments = json['home_visit_appointments'];
    totalPatients = json['total_patients'];
    newPatients = json['new_patients'];
    averageRating = json['average_rating'];
    upcomingAppointment = json['upcoming_appointment'];
    return Model(averageRating: averageRating,clinicAppointments: clinicAppointments,newPatients:newPatients,
    followUpAppointments: followUpAppointments,homeVisitAppointments: homeVisitAppointments,totalPatients:totalPatients,
    onlineAppointments: onlineAppointments,upcomingAppointment:upcomingAppointment);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clinic_appointments'] = clinicAppointments;
    data['online_appointments'] = onlineAppointments;
    data['follow_up_appointments'] = followUpAppointments;
    data['home_visit_appointments'] = homeVisitAppointments;
    data['total_patients'] = totalPatients;
    data['new_patients'] = newPatients;
    data['average_rating'] = averageRating;
    data['upcoming_appointment'] = upcomingAppointment;
    return data;
  }
}