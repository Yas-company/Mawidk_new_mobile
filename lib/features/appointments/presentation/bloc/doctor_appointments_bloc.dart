import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/appointments/domain/use_case/doctor_appointments_use_case.dart';
import 'package:mawidak/features/appointments/presentation/bloc/doctor_appointments_event.dart';


class DoctorAppointmentsBloc extends Bloc<DoctorAppointmentsEvent, BaseState> {
  final DoctorAppointmentsUseCase doctorAppointmentsUseCase;

  DoctorAppointmentsBloc({required this.doctorAppointmentsUseCase}) : super(InitialState()) {
    on<ApplyDoctorAppointmentsEvent>(onApplyDoctorAppointmentsEvent);
    on<ApplyDoctorCancelEvent>(onApplyDoctorCancelEvent);
  }


  Future<void> onApplyDoctorAppointmentsEvent(ApplyDoctorAppointmentsEvent event, Emitter emit) async {
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



  Future<void> onApplyDoctorCancelEvent(ApplyDoctorCancelEvent event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await doctorAppointmentsUseCase.cancelAppointment(id:event.id, model:event.model);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

}
