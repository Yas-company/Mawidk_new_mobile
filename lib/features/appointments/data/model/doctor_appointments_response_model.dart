class DoctorAppointmentsResponseModel {
  final List<DoctorAppointmentsData>? model;

  DoctorAppointmentsResponseModel({
    this.model,
  });

  DoctorAppointmentsResponseModel fromMap(Map<String, dynamic> map) {
    return DoctorAppointmentsResponseModel(
      model: map['model'] != null
          ? List<DoctorAppointmentsData>.from(
        (map['model']).map<DoctorAppointmentsData?>(
              (x) => DoctorAppointmentsData().fromMap(x as Map<String, dynamic>),
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

class DoctorAppointmentsData {
  final int? id;
  final String? patientName;
  final String? patientPhoto;
  final String? appointmentDate;
  final String? appointmentTime;
  final String? clinicName;
  final String? status;
  final int? statusCode;

  DoctorAppointmentsData({
    this.id,
    this.patientName,
    this.patientPhoto,
    this.appointmentDate,
    this.appointmentTime,
    this.clinicName,
    this.status,
    this.statusCode,
  });

   DoctorAppointmentsData fromMap(Map<String, dynamic> json) {
    return DoctorAppointmentsData(
      id: json['id'] as int?,
      patientName: json['patient_name'] as String?,
      patientPhoto: json['patient_photo'] as String?,
      appointmentDate: json['appointment_date'] as String?,
      appointmentTime: json['appointment_time'] as String?,
      clinicName: json['clinic_name'] as String?,
      status: json['status'] as String?,
      statusCode: json['status_code'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_name': patientName,
      'patient_photo': patientPhoto,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'clinic_name': clinicName,
      'status': status,
      'status_code': statusCode,
    };
  }
}

