abstract class DoctorRatingsEvent {
  const DoctorRatingsEvent();
}

class ApplyDoctorRatingsEvent extends DoctorRatingsEvent {
  final int id;
  const ApplyDoctorRatingsEvent({required this.id}) : super();
}
