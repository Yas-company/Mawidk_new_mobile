class AppointmentRequestModel {
  int? doctorId;
  int? clinicId;
  String? appointmentDate;
  String? appointmentTime;
  int? paymentMethod;
  int? status;
  String? notes;

  AppointmentRequestModel(
      {this.doctorId,
        this.clinicId,
        this.appointmentDate,
        this.appointmentTime,
        this.paymentMethod,
        this.status,
        this.notes});

  AppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['clinic_id'] = this.clinicId;
    data['appointment_date'] = this.appointmentDate;
    data['appointment_time'] = this.appointmentTime;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['notes'] = this.notes;
    return data;
  }
}