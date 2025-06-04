import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/show_file/domain/use_case/show_file_use_case.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';

class ShowFileBloc extends Bloc<ShowFileEvent, BaseState> {
  final ShowFileUseCase showFileUseCase;

  ShowFileBloc({required this.showFileUseCase}) : super(InitialState()) {
    on<ApplyBasicInfo>(onApplyBasicInfo);
  }


  Future<void> onApplyBasicInfo(ApplyBasicInfo event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getBasicInfo(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
        emit(LoadedState(r,isMap:false));
      },
    );
  }

}
