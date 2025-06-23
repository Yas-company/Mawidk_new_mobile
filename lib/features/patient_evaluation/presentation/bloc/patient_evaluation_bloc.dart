import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/state/base_state.dart';
import 'package:mawidak/features/patient_evaluation/data/model/add_rate_request_model.dart';
import 'package:mawidak/features/patient_evaluation/domain/use_case/patient_evaluation_use_case.dart';
import 'package:mawidak/features/patient_evaluation/presentation/bloc/patient_evaluation_event.dart';



class PatientEvaluationBloc extends Bloc<PatientEvaluationEvent, BaseState> {
  int? selectedEvaluation ;
  final PatientEvaluationUseCase patientEvaluationUseCase;
  AddRateRequestModel model = AddRateRequestModel();
  PatientEvaluationBloc({required this.patientEvaluationUseCase}) : super(ButtonDisabledState()) {
    on<ApplyPatientEvaluationEvent>(onApplyPatientEvaluationEvent);
    on<ApplyValidationEvent>(onValidate);
  }

  Future<void> onApplyPatientEvaluationEvent(ApplyPatientEvaluationEvent event, Emitter emit) async {
    print(jsonEncode(model));
    emit(ButtonLoadingState());
    final response = await patientEvaluationUseCase.addRate(model:event.model);
    await response.fold((l) async {emit(ErrorState(l));},
          (r) async {
        emit(LoadedState(r,isMap:false));
        Navigator.pop(navigatorKey.currentState!.context,true);
      },
    );
  }

  void onValidate(ApplyValidationEvent event, Emitter emit) {
    print('selectedEvaluation>>'+selectedEvaluation.toString());
    if (selectedEvaluation!=null) {
      emit(ButtonEnabledState());
    } else {
      emit(ButtonDisabledState());
    }
  }

}
