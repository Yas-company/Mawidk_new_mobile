abstract class ShowFileEvent {
  const ShowFileEvent();
}

class ApplyBasicInfo extends ShowFileEvent {
  final int id;
  const ApplyBasicInfo({required this.id}) : super();
}
