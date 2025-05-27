import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/features/survey/data/model/survey_response_model.dart';
import 'package:mawidak/features/survey/presentation/ui/pages/patient_survey_screen.dart';

class SurveyCubit extends Cubit<int> {
  SurveyCubit() : super(0);

  final List<PageModel> surveyPages = patientStaticSurvey;

  void nextPage(int maxPage) {
    if (!validateCurrentPage()) return;

    if (state < maxPage - 1) {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(state + 1);
    } else {
      submitSurvey();
    }
  }

  void prevPage() {
    if (state > 0) {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(state - 1);
    }
  }

  bool validateCurrentPage() {
    final currentQuestions = surveyPages[state].questions;
    for (final question in currentQuestions) {
      if (question.answer == null || (question.type.contains('multi') && (question.answer as List).isEmpty)
          ||((question.type=='text' || (question.type=='radio_button')) && (question.answer??'').isEmpty)
      ) {
        log("Question ID ${question.id} is not answered");
        return false;
      }
    }
    return true;
  }
  void submitSurvey() {
    final fullSurveyJson = surveyPages.map((page) => page.toJson()).toList();

    final Map<String, dynamic> finalJson = {
      "survey": fullSurveyJson,
    };

    log("Full Survey Submission: ${finalJson.toString()}");
    SafeToast.show(message: 'تم بنجاح');
    Navigator.pop(Get.context!);
  }

// void submitSurvey() {
//   final List<Map<String, dynamic>> allAnswers = surveyPages.expand((page) {
//     return page.questions.map((q) => {
//       'id': q.id,
//       'question': q.question,
//       'type': q.type,
//       'answer': q.answer,
//     });
//   }).toList();
//
//   final Map<String, dynamic> finalJson = {
//     "answers": allAnswers,
//   };
//
//   log("Survey Answers: ${finalJson.toString()}");
// }
}