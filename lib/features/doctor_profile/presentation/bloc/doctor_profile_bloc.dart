import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/doctor_profile/data/model/doctor_profile_response_model.dart';
import 'package:mawidak/features/doctor_profile/data/model/favourite_response_model.dart';
import 'package:mawidak/features/doctor_profile/domain/use_case/doctor_profile_use_case.dart';
import 'package:mawidak/features/doctor_profile/presentation/bloc/doctor_profile_event.dart';

class DoctorProfileBloc extends Bloc<DoctorProfileEvent, BaseState> {
  final DoctorProfileUseCase doctorProfileUseCase;
  bool isFavourite = false;
  DoctorProfileBloc({required this.doctorProfileUseCase}) : super(InitialState()) {
    on<ApplyDoctorProfileEvent>(onApplyDoctorProfileEvent);
    on<AddToFavouriteEvent>(onAddToFavouriteEvent);
  }

  Future<void> onApplyDoctorProfileEvent(ApplyDoctorProfileEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await doctorProfileUseCase.getDoctorProfile(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
            DoctorModel item = (r).model?.model ?? DoctorModel();
            isFavourite = item.isFavorite??false;
        emit(LoadedState(r,isMap:false));
      },
    );
  }

  Future<void> onAddToFavouriteEvent(AddToFavouriteEvent event, Emitter emit) async {
    emit(FavouriteLoadingState());
    final response = await doctorProfileUseCase.addToFavourite(model:event.model);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      FavouriteData item = (r).model?.model ?? FavouriteData();
      isFavourite = item.isFavorite??false;
      print('isFavourite>>'+isFavourite.toString());
        emit(FavouriteLoadedState(r));
      },
    );
  }
}
