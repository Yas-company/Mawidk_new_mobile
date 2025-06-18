abstract class PrivacyPolicyEvent {
  const PrivacyPolicyEvent();
}

class ApplyPrivacyPolicyEvent extends PrivacyPolicyEvent {
  final int id;
  const ApplyPrivacyPolicyEvent({required this.id}) : super();
}

