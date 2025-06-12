import 'package:dartz/dartz.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/general_response_model.dart';
import 'package:mawidak/core/base_network/network_repository.dart';
import 'package:mawidak/features/appointments/data/model/accept_appointment_request_model.dart';
import 'package:mawidak/features/patient_appointments/data/model/patient_appointments_response_model.dart';
import 'package:mawidak/features/patient_appointments/domain/repository/patient_appointments_repository.dart';
import '../../../../core/base_network/error/handler/error_model.dart';
import '../../../../core/base_network/error/handler/exception_enum.dart';

class PatientAppointmentsRepositoryImpl extends MainRepository implements PatientAppointmentsRepository {
  PatientAppointmentsRepositoryImpl({
    required super.remoteData,
    required super.networkInfo,
  });

  @override
  Future<Either> getPatientAppointments()async {
    try {
      final result = await remoteData.get(
        path: ApiEndpointsConstants.patientAppointments,
        headers: headers,
        model: GeneralResponseModel(model:PatientAppointmentsResponseModel()),
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
  Future<Either> cancelAppointment({required int id, required AcceptAppointmentRequestModel model}) async {
    try {
      final result = await remoteData.post(
        body:model.toJson(),
        path: ApiEndpointsConstants.doctorAppointmentAccept(id),
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
