import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/appointments/data/model/doctor_appointments_response_model.dart';
import 'package:mawidak/features/appointments/domain/use_case/doctor_appointments_use_case.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_event.dart';


class DoctorAppointmentsBloc extends Bloc<DoctorAppointmentsEvent, BaseState> {
  final DoctorAppointmentsUseCase doctorAppointmentsUseCase;
  List<DoctorAppointmentsData> pendingList = [];

  DoctorAppointmentsBloc({required this.doctorAppointmentsUseCase}) : super(InitialState()) {
    on<ApplyDoctorAppointmentsEvent>(onApplyDoctorAppointmentsEvent);
    on<ApplyDoctorPendingAppointmentsEvent>(onApplyDoctorPendingAppointmentsEvent);
    on<ApplyDoctorCancelEvent>(onApplyDoctorCancelEvent);
    on<ApplyDoctorAcceptEvent>(onApplyDoctorAcceptEvent);
  }


  Future<void> onApplyDoctorAppointmentsEvent(ApplyDoctorAppointmentsEvent event, Emitter emit) async {
    add(ApplyDoctorPendingAppointmentsEvent());
    emit(LoadingState());
    final response = await doctorAppointmentsUseCase.getDoctorAppointments();
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      final list = (r).model?.model?? [];
      if(list.isEmpty){
        emit(EmptyState(r.message,));
        return;
      }
      emit(LoadedState(r,isMap:false));
    },
    );
  }

  Future<void> onApplyDoctorPendingAppointmentsEvent(ApplyDoctorPendingAppointmentsEvent event, Emitter emit) async {
    // emit(LoadingState());
    final pendingAppointments = await doctorAppointmentsUseCase.getDoctorPendingAppointments();
    await pendingAppointments.fold((l) async {
      emit(ErrorState(l));}, (r) async {
      pendingList = (r).model?.model?? [];
      // print('pendingList>>'+pendingList.toString());
    },
    );
  }

  Future<void> onApplyDoctorCancelEvent(ApplyDoctorCancelEvent event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await doctorAppointmentsUseCase.cancelAppointment(id:event.id, model:event.model);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

  Future<void> onApplyDoctorAcceptEvent(ApplyDoctorAcceptEvent event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await doctorAppointmentsUseCase.acceptAppointment(id:event.id, model:event.model);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

}
