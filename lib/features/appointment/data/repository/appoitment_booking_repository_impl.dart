import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/appointment/data/model/appointment_reques_model.dart';
import 'package:mawidak/features/appointment/domain/repository/appoitment_booking_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class AppointmentBookingRepositoryImpl extends MainRepository implements AppointmentBookingRepository {
  AppointmentBookingRepositoryImpl({
    required super.remoteData,
    required super.networkInfo, // For checking network connection
  });


  @override
  Future<Either> bookAppointment({required AppointmentRequestModel model}) async {
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.bookAppointment,
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
}
