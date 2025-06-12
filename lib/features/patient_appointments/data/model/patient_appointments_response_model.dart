class PatientAppointmentsResponseModel {
  final PatientAppointmentsData? model;

  PatientAppointmentsResponseModel({this.model});

   PatientAppointmentsResponseModel fromMap(Map<String, dynamic> json) {
    return PatientAppointmentsResponseModel(
      model: json['model'] != null
          ? PatientAppointmentsData().fromMap(json['model'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (model != null) 'model': model!.toMap(),
    };
  }
}

class PatientAppointmentsData {
  final List<AppointmentData>? all;
  final List<AppointmentData>? upcoming;
  final List<AppointmentData>? past;

  PatientAppointmentsData({
    this.all,
    this.upcoming,
    this.past,
  });

   PatientAppointmentsData fromMap(Map<String, dynamic> json) {
    return PatientAppointmentsData(
      all: json['all'] != null
          ? List<AppointmentData>.from(
          json['all'].map((v) => AppointmentData().fromMap(v)))
          : null,
      upcoming: json['upcoming'] != null
          ? List<AppointmentData>.from(
          json['upcoming'].map((v) => AppointmentData().fromMap(v)))
          : null,
      past: json['past'] != null
          ? List<AppointmentData>.from(
          json['past'].map((v) => AppointmentData().fromMap(v)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (all != null) 'all': all!.map((v) => v.toMap()).toList(),
      if (upcoming != null) 'upcoming': upcoming!.map((v) => v.toMap()).toList(),
      if (past != null) 'past': past!.map((v) => v.toMap()).toList(),
    };
  }
}

class AppointmentData {
  final int? id;
  final String? appointmentDate;
  final String? appointmentTime;
  final String? datetime;
  final String? doctorName;
  final String? doctorAvatar;
  final String? doctorSpeciality;
  final String? status;
  final bool? canCancel;

  AppointmentData({
    this.id,
    this.appointmentDate,
    this.appointmentTime,
    this.datetime,
    this.doctorName,
    this.doctorAvatar,
    this.doctorSpeciality,
    this.status,
    this.canCancel,
  });

   AppointmentData fromMap(Map<String, dynamic> json) {
    return AppointmentData(
      id: json['id'],
      appointmentDate: json['appointment_date'],
      appointmentTime: json['appointment_time'],
      datetime: json['datetime'],
      doctorName: json['doctor_name'],
      doctorAvatar: json['doctor_avatar'],
      doctorSpeciality: json['doctor_speciality'],
      status: json['status'],
      canCancel: json['can_cancel'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'datetime': datetime,
      'doctor_name': doctorName,
      'doctor_avatar': doctorAvatar,
      'doctor_speciality': doctorSpeciality,
      'status': status,
      'can_cancel': canCancel,
    };
  }
}
