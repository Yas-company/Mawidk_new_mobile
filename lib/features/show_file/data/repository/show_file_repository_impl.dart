import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/show_file/data/model/add_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/all_consultaions_response_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/add_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/add_note_request_model.dart';
import 'package:mawidak/features/show_file/data/model/all_notes_response_model.dart';
import 'package:mawidak/features/show_file/data/model/basic_information_response_model.dart';
import 'package:mawidak/features/show_file/data/model/diagnosis_response_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/drug_response_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/update_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/medical_history_response_model.dart';
import 'package:mawidak/features/show_file/data/model/update_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/update_note_request_model.dart';
import 'package:mawidak/features/show_file/domain/repository/show_file_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class ShowFileRepositoryImpl extends MainRepository implements ShowFileRepository {
  ShowFileRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> getBasicInfo({required int id})async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.basicInformation+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:BasicInformationResponseModel()),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> getMedicalHistory({required int id})async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.medicalHistory+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:MedicalHistoryResponseModel()),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> diagnosis({required int id}) async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.diagnosis+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:DiagnosisResponseModel()),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> addDiagnosis({required AddDiagnosisRequestModel model}) async{
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.addDiagnosis,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> updateDiagnosis({required UpdateDiagnosisRequestModel model,required int id}) async{
    try {
      final result = await remoteData.put(
        body:model.toJson(),
        path: ApiEndpointsConstants.updateDiagnosis+id.toString(),
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }



  @override
  Future<Either> addDrug({required AddDrugRequestModel model}) async{
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.addDrug,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> deleteDrugs({required int id}) async{
    try {
      final result = await remoteData.delete(
        path: ApiEndpointsConstants.deleteDrug+id.toString(),
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> getDrugs({required int id}) async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.getDrugs+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:DrugResponseModel()),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> updateDrug({required UpdateDrugRequestModel model, required int id}) async{
    try {
      final result = await remoteData.put(
        body:model.toJson(),
        path: ApiEndpointsConstants.updateDrug+id.toString(),
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  // ______________________________ Notes

  @override
  Future<Either> addNote({required AddNoteRequestModel model}) async{
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.addNote,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> deleteNote({required int id}) async{
    try {
      final result = await remoteData.delete(
        path: ApiEndpointsConstants.deleteNote+id.toString(),
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> getNotes({required int id}) async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.getNotes+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:AllNotesResponseModel()),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> updateNote({required UpdateNoteRequestModel model, required int id}) async{
    try {
      final result = await remoteData.put(
        body:model.toJson(),
        path: ApiEndpointsConstants.updateNote+id.toString(),
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> addConsultation({required AddConsultationRequestModel model}) async {
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.addConsultation,
        headers: headers,
        model: GeneralResponseModel(),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

  @override
  Future<Either> getConsultations({required int id}) async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.getConsultations+id.toString(),
        headers: headers,
        model: GeneralResponseModel(model:AllConsultationsResponseModel()),
      );
      return result;
    } catch (e) {
      return Left(
        ErrorExceptionModel(
            message: e.toString(),
            exceptionEnum: ExceptionEnum.unknownException),
      );
    }
  }

}
