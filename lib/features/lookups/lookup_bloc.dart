import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/lookups/cities_response_model.dart';
import 'package:mawidak/features/lookups/lookup_event.dart';
import 'package:mawidak/features/lookups/lookup_use_case.dart';

class LookupBloc extends Bloc<LookupEvent, BaseState> {
  final LookupUseCase lookupUseCase;
  List<CitiesData> itemList = [];
  LookupBloc({required this.lookupUseCase}) : super(InitialState()) {
    on<FetchCitiesEvent>(onFetchCitiesEvent);
  }


  Future<void> onFetchCitiesEvent(FetchCitiesEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await lookupUseCase.fetchCities();
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        itemList = (r).model?.model?? [];
        if(itemList.isEmpty){
          emit(EmptyState(r.message,));
          return;
        }
        emit(LoadedState(r));
      },
    );
  }
}
