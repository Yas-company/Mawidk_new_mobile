import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/search/domain/domain/use_case/search_use_case.dart';
import 'package:mawidak/features/search/presentation/bloc/search_event.dart';

class SearchBloc extends Bloc<SearchEvent, BaseState> {
  final SearchUseCase searchUseCase;
  int itemLength = 0;
  bool isMap = false;
  String lastSearchKey = '';
  // TextEditingController controller = TextEditingController();

  SearchBloc({required this.searchUseCase}) : super(InitialState()) {
    on<ApplySearchForPatient>(onApplySearchForPatient);
    on<ApplySearchMap>(onApplySearchMap);
    on<ApplyIsMapEvent>(onApplyIsMapEvent);
    on<ApplyFilterEvent>(onApplyFilterEvent);
  }


  Future<void> onApplySearchForPatient(ApplySearchForPatient event, Emitter emit) async {
    lastSearchKey  = event.key;
    emit(EmptyState(''));
    emit(LoadingState());
    final response = await searchUseCase.searchForPatient(key:event.key);
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        final list = (r).model?.model?? [];
        itemLength = list.length;
        if(list.isEmpty){
          emit(EmptyState('لا يوجد نتائج لبحث "${event.key}"'));
          // emit(EmptyState(r.message,));
          return;
        }
        emit(LoadedState(r,isMap:false));
      },
    );
  }

  Future<void> onApplySearchMap(ApplySearchMap event, Emitter emit) async {
    emit(LoadingState());
    final response = await searchUseCase.searchMap(model:event.searchMapRequestModel);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
        // final list = (r).model?.model?? [];
        emit(LoadedState(r,isMap:false));
      },
    );
  }

  Future<void> onApplyIsMapEvent(ApplyIsMapEvent event, Emitter emit) async {
    isMap = event.isMap;
    emit(IsMapState(isMap:isMap));
  }

  Future<void> onApplyFilterEvent(ApplyFilterEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await searchUseCase.filter(model:event.filterRequestModel);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      final list = (r).model?.model?? [];
      itemLength = list.length;
      if(list.isEmpty){
        emit(EmptyState('لا يوجد نتائج'));
        // emit(EmptyState(r.message,));
        return;
      }
      emit(LoadedState(r,isMap:false));
    },
    );
  }
}
