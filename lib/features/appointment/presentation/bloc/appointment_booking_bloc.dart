import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/appointment/data/model/appointment_reques_model.dart';
import 'package:mawidak/features/appointment/domain/use_case/appoitment_booking_use_case.dart';
import 'package:mawidak/features/appointment/presentation/bloc/appointment_booking_event.dart';



class AppointmentBookingBloc extends Bloc<AppointmentBookingEvent, BaseState> {
  final AppointmentBookingUseCase appointmentBookingUseCase;
  AppointmentRequestModel model =AppointmentRequestModel();
  AppointmentBookingBloc({required this.appointmentBookingUseCase}) : super(InitialState()) {
    on<ApplyAppointmentBookingEvent>(onApplyAppointmentBookingEvent);
  }

  Future<void> onApplyAppointmentBookingEvent(ApplyAppointmentBookingEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await appointmentBookingUseCase.bookAppointment(model:event.model);
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        emit(LoadedState(r,isMap:false));
      },
    );
  }

}
