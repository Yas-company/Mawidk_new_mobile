abstract class DoctorRatingsEvent {
  const DoctorRatingsEvent();
}

class ApplyDoctorRatingsEvent extends DoctorRatingsEvent {
  final int id;
  final bool isRate;
  const ApplyDoctorRatingsEvent({required this.id,required this.isRate}) : super();
}
