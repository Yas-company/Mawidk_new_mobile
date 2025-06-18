import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/show_file/domain/use_case/show_file_use_case.dart';
import 'package:mawidak/features/show_file/presentation/bloc/show_file_event.dart';

class ShowFileBloc extends Bloc<ShowFileEvent, BaseState> {
  final ShowFileUseCase showFileUseCase;

  ShowFileBloc({required this.showFileUseCase}) : super(InitialState()) {
    on<ApplyBasicInfo>(onApplyBasicInfo);
    on<ApplyMedicalHistory>(onApplyMedicalHistory);
    on<ApplyDiagnosis>(onApplyDiagnosis);
    on<ApplyAddingDiagnosis>(onApplyAddingDiagnosis);
    on<ApplyEditingDiagnosis>(onApplyEditingDiagnosis);
    on<ApplyDrugs>(onApplyDrugs);
    on<ApplyAddingDrugs>(onApplyAddingDrug);
    on<ApplyEditingDrugs>(onApplyEditingDrug);
    on<ApplyDeleteDrugs>(onApplyDeleteDrug);
    on<ApplyNotes>(onApplyNotes);
    on<ApplyAddingNote>(onApplyAddingNote);
    on<ApplyEditingNote>(onApplyEditingNote);
    on<ApplyDeleteNote>(onApplyDeleteNote);
    on<ApplyConsultations>(onApplyConsultations);
    on<ApplyAddingConsultation>(onApplyAddingConsultation);
    on<ApplyConsultationById>(onApplyConsultationById);
  }


  Future<void> onApplyBasicInfo(ApplyBasicInfo event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getBasicInfo(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
        emit(LoadedState(r,isMap:false));
      },
    );
  }

  Future<void> onApplyMedicalHistory(ApplyMedicalHistory event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getMedicalHistory(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(LoadedState(r,isMap:false));
    },
    );
  }

  Future<void> onApplyDiagnosis(ApplyDiagnosis event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getDiagnosis(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      final list = (r).model?.model?? [];
      if(list.isEmpty){
        emit(EmptyState(r.message,));
        return;
      }
      emit(LoadedState(r,isMap:false));
    },
    );
  }

  Future<void> onApplyAddingDiagnosis(ApplyAddingDiagnosis event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.addDiagnosis(model:event.addDiagnosisRequestModel);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

  Future<void> onApplyEditingDiagnosis(ApplyEditingDiagnosis event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.updateDiagnosis(model:event.updateDiagnosisRequestModel,id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }


 //////////////////////////////////////// // Drug

  Future<void> onApplyDrugs(ApplyDrugs event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getDrugs(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      final list = (r).model?.model?? [];
      if(list.isEmpty){
        emit(EmptyState(r.message,));
        return;
      }
      emit(LoadedState(r,isMap:false));
    },
    );
  }

  Future<void> onApplyAddingDrug(ApplyAddingDrugs event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.addDrug(model:event.addDrugRequestModel);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

  Future<void> onApplyEditingDrug(ApplyEditingDrugs event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.updateDrug(model:event.updateDrugRequestModel,id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

  Future<void> onApplyDeleteDrug(ApplyDeleteDrugs event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.deleteDrugs(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }


  //////////////////////////////////////// // Drug

  Future<void> onApplyNotes(ApplyNotes event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getNotes(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      final list = (r).model?.model?? [];
      if(list.isEmpty){
        emit(EmptyState(r.message,));
        return;
      }
      emit(LoadedState(r,isMap:false));
    },
    );
  }

  Future<void> onApplyAddingNote(ApplyAddingNote event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.addNote(model:event.addNoteRequestModel);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

  Future<void> onApplyEditingNote(ApplyEditingNote event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.updateNote(model:event.updateNoteRequestModel,id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

  Future<void> onApplyDeleteNote(ApplyDeleteNote event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.deleteNote(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }



  //////////////////////////////////////// // Consultation

  Future<void> onApplyConsultations(ApplyConsultations event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getConsultations(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      final list = (r).model?.model?? [];
      if(list.isEmpty){
        emit(EmptyState(r.message,));
        return;
      }
      emit(LoadedState(r,isMap:false));
    },
    );
  }

  Future<void> onApplyAddingConsultation(ApplyAddingConsultation event, Emitter emit) async {
    emit(ButtonLoadingState());
    final response = await showFileUseCase.addConsultation(model:event.addConsultationRequestModel);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(FormLoadedState(r,));
    },
    );
  }

  Future<void> onApplyConsultationById(ApplyConsultationById event, Emitter emit) async {
    emit(LoadingState());
    final response = await showFileUseCase.getConsultationById(id:event.id);
    await response.fold((l) async {emit(ErrorState(l));}, (r) async {
      emit(LoadedState(r,isMap:false));
    },
    );
  }

}

