import 'package:dartz/dartz.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/patient_survey_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_doctor_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_submit_request_model.dart';


abstract class SurveyRepository {
  Future<Either<dynamic, dynamic>> getSurvey({required UserType type});
  Future<Either<dynamic, dynamic>> submitSurvey({required SurveySubmitRequestModel model});
  Future<Either<dynamic, dynamic>> submitPatientSurvey({required PatientSurveyRequestModel model});
  Future<Either<dynamic, dynamic>> submitSurveyDoctor({required SurveyDoctorRequestModel model});
}
