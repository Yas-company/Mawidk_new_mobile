import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/home/domain/use_case/home_patient_use_case.dart';
import 'package:mawidak/features/home/presentation/bloc/home_patient_event.dart';

class BannerBloc extends Bloc<HomePatientEvent, BaseState> {
  final HomePatientUseCase homeUseCase;
  int currentIndex = 0;
  BannerBloc({required this.homeUseCase}) : super(const InitialState()) {
    on<BannersEvent>(onGetBanners);
    on<ChangeIndexEvent>(onChangeIndex);
  }
  Future<void> onGetBanners(BannersEvent event, Emitter<BaseState> emit) async {
    emit(LoadingState());
    final banners = await homeUseCase.getBanners();
    banners.fold((l) => emit(ErrorState(l)), (r) => emit(LoadedState(r)));
  }
  Future<void> onChangeIndex(ChangeIndexEvent event, Emitter<BaseState> emit) async {
    currentIndex = event.index;
    emit(ChangeIndexState(currentIndex));
  }
}
