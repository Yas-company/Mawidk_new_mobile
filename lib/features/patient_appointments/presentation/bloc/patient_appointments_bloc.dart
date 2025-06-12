import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';
import 'package:mawidak/features/patient_appointments/data/model/patient_appointments_response_model.dart';
import 'package:mawidak/features/patient_appointments/domain/use_case/patient_appointments_use_case.dart';
import 'package:mawidak/features/patient_appointments/presentation/bloc/patient_appointments_event.dart';


class PatientAppointmentsBloc extends Bloc<PatientAppointmentsEvent, BaseState> {
  final PatientAppointmentsUseCase patientAppointmentsUseCase;
  List<AppointmentData> allList = [];
  List<AppointmentData> nextList = [];
  List<AppointmentData> pastList = [];

  PatientAppointmentsBloc({required this.patientAppointmentsUseCase}) : super(InitialState()) {
    on<ApplyPatientAppointmentsEvent>(onApplyPatientAppointmentsEvent);
    on<ApplyPatientCancelEvent>(onApplyPatientAcceptEvent);
  }


  Future<void> onApplyPatientAppointmentsEvent(ApplyPatientAppointmentsEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await patientAppointmentsUseCase.getPatientAppointments();
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      final item = ((r).model?.model?? PatientAppointmentsData()) as PatientAppointmentsData;
      allList = item.all??[];
      nextList = item.upcoming??[];
      pastList = item.past??[];
      emit(LoadedState(r));
    },
    );
  }

  Future<void> onApplyPatientAcceptEvent(ApplyPatientCancelEvent event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await patientAppointmentsUseCase.cancelAppointment(id:event.id, model:event.model);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

}
