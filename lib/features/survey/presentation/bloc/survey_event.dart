import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/features/survey/data/model/patient_survey_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_doctor_request_model.dart';
import 'package:mawidak/features/survey/data/model/survey_submit_request_model.dart';

abstract class SurveyEvent {
  const SurveyEvent();
}

class GetSurveyEvent extends SurveyEvent {
  final UserType type;
  const GetSurveyEvent({required this.type}) : super();
}

class NextPageEvent extends SurveyEvent {
  final PageController controller;
  const NextPageEvent({required this.controller}) : super();
}

class PrevPageEvent extends SurveyEvent {
  final PageController controller;
  const PrevPageEvent({required this.controller}) : super();
}

class ValidateSurveyEvent extends SurveyEvent {}

class SubmitSurveyEvent extends SurveyEvent {
  final SurveySubmitRequestModel model;
  const SubmitSurveyEvent({required this.model}) : super();
}

class SubmitSurveyDoctorEvent extends SurveyEvent {
  final SurveyDoctorRequestModel model;
  const SubmitSurveyDoctorEvent({required this.model}) : super();
}


class SubmitPatientSurveyEvent extends SurveyEvent {
  final PatientSurveyRequestModel model;
  const SubmitPatientSurveyEvent({required this.model}) : super();
}

class FillSelectedFilesEvent extends SurveyEvent {
  final List<File> files;
  const FillSelectedFilesEvent({required this.files}) : super();
}