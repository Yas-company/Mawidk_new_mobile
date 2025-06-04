import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/all_patients/domain/use_case/patients_use_case.dart';
import 'package:mawidak/features/all_patients/presentation/bloc/patients_event.dart';

class PatientsBloc extends Bloc<PatientsEvent, BaseState> {
  final PatientsUseCase patientsUseCase;

  PatientsBloc({required this.patientsUseCase}) : super(InitialState()) {
    on<GetDoctorPatients>(onGetDoctorPatients);
  }

  Future<void> onGetDoctorPatients(GetDoctorPatients event, Emitter emit) async {
    emit(LoadingState());
    final response = await patientsUseCase.getDoctorPatients();
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        emit(LoadedState(r,isMap:false));
      },
    );
  }
}
