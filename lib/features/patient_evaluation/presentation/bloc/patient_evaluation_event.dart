import 'package:mawidak/features/patient_evaluation/data/model/add_rate_request_model.dart';

abstract class PatientEvaluationEvent {
  const PatientEvaluationEvent();
}

class ApplyPatientEvaluationEvent extends PatientEvaluationEvent {
  final AddRateRequestModel model;
  const ApplyPatientEvaluationEvent({required this.model}) : super();
}


class ApplyValidationEvent extends PatientEvaluationEvent {
  const ApplyValidationEvent() : super();
}

