import 'package:dartz/dartz.dart';

abstract class PrivacyPolicyRepository {
  Future<Either<dynamic, dynamic>> getPrivacyPolicy({required int id});
}
