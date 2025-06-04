import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/appointments/data/model/cancel_appointment_request_model.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';
import 'package:mawidak/features/appointments/domain/repository/doctor_appointments_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class DoctorAppointmentsRepositoryImpl extends MainRepository implements DoctorAppointmentsRepository {
  DoctorAppointmentsRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> getDoctorAppointments()async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.doctorAppointments,
        headers: headers,
        model: GeneralResponseModel(model:DoctorAppointmentsResponseModel()),
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
  Future<Either> cancelAppointment({required int id,required CancelAppointmentRequestModel model}) async{
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.doctorAppointmentCancel(id),
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
}
