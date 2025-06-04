import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/search_results_for_doctor/domain/use_case/search_for_doctors_use_case.dart';
import 'package:mawidak/features/search_results_for_doctor/presentation/bloc/search_for_doctors_event.dart';

class SearchForDoctorsBloc extends Bloc<SearchForDoctorsEvent, BaseState> {
  final SearchForDoctorsUseCase searchUseCase;
  int itemLength = 0;
  bool isMap = false;
  String lastSearchKey = '';
  // TextEditingController controller = TextEditingController();

  SearchForDoctorsBloc({required this.searchUseCase}) : super(InitialState()) {
    on<ApplySearchForDoctor>(onApplySearchForPatient);
  }


  Future<void> onApplySearchForPatient(ApplySearchForDoctor event, Emitter emit) async {
    lastSearchKey  = event.key;
    emit(EmptyState(''));
    emit(LoadingState());
    final response = await searchUseCase.searchForDoctor(key:event.key);
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



}
