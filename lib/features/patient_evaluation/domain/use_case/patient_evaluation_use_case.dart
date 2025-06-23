import 'package:dartz/dartz.dart';
import 'package:mawidak/features/patient_evaluation/data/model/add_rate_request_model.dart';
import 'package:mawidak/features/patient_evaluation/domain/repository/patient_evaluation_repository.dart';



class PatientEvaluationUseCase {
  final PatientEvaluationRepository patientEvaluationRepository;

  PatientEvaluationUseCase({required this.patientEvaluationRepository});

  Future<Either> addRate({required AddRateRequestModel model}) async {
    return await patientEvaluationRepository.addRate(model: model);
  }
}
