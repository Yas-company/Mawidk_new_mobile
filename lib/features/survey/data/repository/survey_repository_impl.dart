import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/patient_survey_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_doctor_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/data/model/survey_submit_request_model.dart';
import 'package:mawidak/features/survey/domain/repository/survey_repo.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class SurveyRepositoryImpl extends MainRepository implements SurveyRepository {
  SurveyRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getSurvey({required UserType type}) async {
    try {
      final result = await remoteData.get(
        path: '${ApiEndpointsConstants.survey}/${type.index}',
        headers: headers,
        model: GeneralResponseModel(model: SurveyModel()),
      );
      return result;
    } catch (e) {
      // If an error occurs, return the error wrapped in Left
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> submitSurvey({required SurveySubmitRequestModel model}) async{
    try {
      final result = await remoteData.post(
        body: model.toJson(),
        path: ApiEndpointsConstants.surveyAnswer,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      // If an error occurs, return the error wrapped in Left
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> submitSurveyDoctor({required SurveyDoctorRequestModel model}) async{
    try {
      final result = await remoteData.postMultiPartDataNew(
        body: model,
        path: ApiEndpointsConstants.addSurveyDoctor,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> submitPatientSurvey({required PatientSurveyRequestModel model})async {
    try {
      final result = await remoteData.post(
        body: model.toJson(),
        path: ApiEndpointsConstants.addSurveyPatient,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }
}
