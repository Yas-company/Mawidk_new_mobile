import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/home/data/model/banner_response_model.dart';
import 'package:mawidak/features/home/data/model/doctor_profile_status_response_model.dart';
import 'package:mawidak/features/home/data/model/doctors_for_patient_response_model.dart';
import 'package:mawidak/features/home/data/model/home_details_response_model.dart';
import 'package:mawidak/features/home/domain/repository/home_patient_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class HomePatientRepositoryImpl extends MainRepository implements HomePatientRepository {
  HomePatientRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });

  @override
  Future<Either> getDoctors() async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.getDoctorsForPatient,
        headers: headers,
        model: GeneralResponseModel(model:DoctorsForPatientResponseModel()),
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
  Future<Either> getBanners() async{
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.banners,
        headers: headers,
        model: GeneralResponseModel(model:BannerResponseModel()),
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
  Future<Either> getDoctorProfileStatus() async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.doctorProfileStatus,
        headers: headers,
        model: GeneralResponseModel(model:DoctorProfileStatusResponseModel()),
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
  Future<Either> getDoctorHomeDetails() async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.detailsHomeDoctor,
        headers: headers,
        model: GeneralResponseModel(model:DoctorHomeDetailsResponseModel()),
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
