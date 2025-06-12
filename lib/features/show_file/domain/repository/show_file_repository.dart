import 'package:dartz/dartz.dart';
import 'package:mawidak/features/show_file/data/model/add_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/add_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/add_note_request_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/update_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/update_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/update_note_request_model.dart';

abstract class ShowFileRepository {
  Future<Either<dynamic, dynamic>> getBasicInfo({required int id});
  Future<Either<dynamic, dynamic>> getMedicalHistory({required int id});

  Future<Either<dynamic, dynamic>> diagnosis({required int id});
  Future<Either<dynamic, dynamic>> addDiagnosis({required AddDiagnosisRequestModel model});
  Future<Either<dynamic, dynamic>> updateDiagnosis({required UpdateDiagnosisRequestModel model,required int id});

  // drug
  Future<Either<dynamic, dynamic>> getDrugs({required int id});
  Future<Either<dynamic, dynamic>> deleteDrugs({required int id});
  Future<Either<dynamic, dynamic>> addDrug({required AddDrugRequestModel model});
  Future<Either<dynamic, dynamic>> updateDrug({required UpdateDrugRequestModel model,required int id});

  // Note
  Future<Either<dynamic, dynamic>> getNotes({required int id});
  Future<Either<dynamic, dynamic>> deleteNote({required int id});
  Future<Either<dynamic, dynamic>> addNote({required AddNoteRequestModel model});
  Future<Either<dynamic, dynamic>> updateNote({required UpdateNoteRequestModel model,required int id});

  // Consultation
  Future<Either<dynamic, dynamic>> getConsultations({required int id});
  Future<Either<dynamic, dynamic>> addConsultation({required AddConsultationRequestModel model});
  // Future<Either<dynamic, dynamic>> updateConsultation({required UpdateNoteRequestModel model,required int id});
}
