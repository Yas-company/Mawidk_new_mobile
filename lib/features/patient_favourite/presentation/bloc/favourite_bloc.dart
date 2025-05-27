import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/patient_favourite/data/domain/use_case/favourite_use_case.dart';
import 'package:mawidak/features/patient_favourite/presentation/bloc/favourite_event.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, BaseState> {
  final FavouriteUseCase favouriteUseCase;

  FavouriteBloc({required this.favouriteUseCase}) : super(InitialState()) {
    on<ApplyFavouriteEvent>(onApplyFavouriteEvent);
  }


  Future<void> onApplyFavouriteEvent(ApplyFavouriteEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await favouriteUseCase.getFavouriteDoctors();
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
