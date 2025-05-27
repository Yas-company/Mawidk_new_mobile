abstract class DoctorsOfSpecialityEvent {
  const DoctorsOfSpecialityEvent();
}

class ApplyDoctorsOfSpecialityEvent extends DoctorsOfSpecialityEvent {
  final int id;
  const ApplyDoctorsOfSpecialityEvent({required this.id}) : super();
}

