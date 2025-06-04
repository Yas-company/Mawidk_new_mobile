abstract class SearchForDoctorsEvent {
  const SearchForDoctorsEvent();
}

class ApplySearchForDoctor extends SearchForDoctorsEvent {
  final String key;
  const ApplySearchForDoctor({required this.key}) : super();
}
