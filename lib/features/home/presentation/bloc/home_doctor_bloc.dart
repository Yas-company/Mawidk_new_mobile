import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/home/domain/use_case/home_patient_use_case.dart';
import 'package:mawidak/features/home/presentation/bloc/home_patient_event.dart';

class HomeDoctorBloc extends Bloc<HomePatientEvent, BaseState> {
  final HomePatientUseCase homePatientUseCase;

  HomeDoctorBloc({required this.homePatientUseCase}) : super(InitialState()) {
    on<DoctorHomeDetailsEvent>(onDoctorHomeDetailsEvent);
  }


  Future<void> onDoctorHomeDetailsEvent(DoctorHomeDetailsEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await homePatientUseCase.getDoctorHomeDetails();
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        final list = (r).model?.model?? [];
        if(list.isEmpty){
          emit(EmptyState(r.message,));
          return;
        }
        emit(LoadedState(r));
      },
    );
  }
}
