import 'package:dartz/dartz.dart';
import 'package:mawidak/features/privacy_policy/domain/repository/privacy_policy_repository.dart';

class PrivacyPolicyUseCase {
  final PrivacyPolicyRepository privacyPolicyRepository;

  PrivacyPolicyUseCase({required this.privacyPolicyRepository});

  Future<Either> getPrivacyPolicy({required int id}) async {
    return await privacyPolicyRepository.getPrivacyPolicy(id: id);
  }
}