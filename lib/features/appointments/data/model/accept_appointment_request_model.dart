class AcceptAppointmentRequestModel {
  final int status;

  AcceptAppointmentRequestModel({
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}

// "status": 5 //  Confirmed = 2 or Completed = 5; or
// NoShow = 6 or CancelledByDoctor = 3 or CancelledByPatient = 4 ;