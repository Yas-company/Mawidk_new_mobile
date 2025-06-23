import 'package:dartz/dartz.dart';
import 'package:mawidak/features/patient_evaluation/data/model/add_rate_request_model.dart';

abstract class PatientEvaluationRepository {
  Future<Either<dynamic, dynamic>> addRate({required AddRateRequestModel model});
}
