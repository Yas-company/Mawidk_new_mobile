import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/doctor_ratings/domain/use_case/doctor_ratings_use_case.dart';
import 'package:mawidak/features/doctor_ratings/presentation/bloc/doctor_ratings_event.dart';

class DoctorRatingsBloc extends Bloc<DoctorRatingsEvent, BaseState> {
  final DoctorRatingsUseCase doctorRatingsUseCase;
  DoctorRatingsBloc({required this.doctorRatingsUseCase}) : super(InitialState()) {
    on<ApplyDoctorRatingsEvent>(onApplyDoctorRatingsEvent);
  }

  Future<void> onApplyDoctorRatingsEvent(ApplyDoctorRatingsEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await doctorRatingsUseCase.getDoctorRatingsById(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
        final list = (r).model?.model?? [];
        if(list.isEmpty){
          emit(EmptyState('لا توجد تقييمات'));
          return;
        }
        emit(LoadedState(r));
      },
    );
  }
}
