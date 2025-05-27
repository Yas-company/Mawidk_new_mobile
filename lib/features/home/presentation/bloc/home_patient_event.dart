abstract class HomePatientEvent {
  const HomePatientEvent();
}

class DoctorsOfPatientEvent extends HomePatientEvent {
  const DoctorsOfPatientEvent() : super();
}

class BannersEvent extends HomePatientEvent {
  const BannersEvent() : super();
}

class ChangeIndexEvent extends HomePatientEvent {
  final int index;
  const ChangeIndexEvent(this.index) : super();
}

class DoctorProfileStatusEvent extends HomePatientEvent {
  const DoctorProfileStatusEvent() : super();
}

class DoctorHomeDetailsEvent extends HomePatientEvent {
  const DoctorHomeDetailsEvent() : super();
}