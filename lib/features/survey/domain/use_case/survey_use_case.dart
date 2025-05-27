import 'package:dartz/dartz.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/patient_survey_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_doctor_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_submit_request_model.dart';
import 'package:mawidak/features/survey/domain/repository/survey_repo.dart';


class SurveyUseCase {
  final SurveyRepository surveyRepository;
  SurveyUseCase({required this.surveyRepository});

  Future<Either> getSurvey({required UserType type}) async {
    return await surveyRepository.getSurvey(type:type);
  }
  Future<Either> submitSurvey({required SurveySubmitRequestModel model}) async {
    return await surveyRepository.submitSurvey(model:model);
  }

  Future<Either> submitPatientSurvey({required PatientSurveyRequestModel model}) async {
    return await surveyRepository.submitPatientSurvey(model:model);
  }
  Future<Either> submitSurveyDoctor({required SurveyDoctorRequestModel model}) async {
    return await surveyRepository.submitSurveyDoctor(model:model);
  }
}
