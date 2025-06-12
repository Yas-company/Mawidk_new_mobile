import 'package:dartz/dartz.dart';
import 'package:mawidak/features/show_file/data/model/add_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/add_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/add_note_request_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/update_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/update_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/update_note_request_model.dart';
import 'package:mawidak/features/show_file/domain/repository/show_file_repository.dart';


class ShowFileUseCase {
  final ShowFileRepository showFileRepository;

  ShowFileUseCase({required this.showFileRepository});

  Future<Either> getBasicInfo({required int id}) async {
    return await showFileRepository.getBasicInfo(id: id);
  }

  Future<Either> getMedicalHistory({required int id}) async {
    return await showFileRepository.getMedicalHistory(id: id);
  }


  Future<Either> getDiagnosis({required int id}) async {
    return await showFileRepository.diagnosis(id: id);
  }

  Future<Either> addDiagnosis({required AddDiagnosisRequestModel model}) async {
    return await showFileRepository.addDiagnosis(model: model);
  }

  Future<Either> updateDiagnosis({required UpdateDiagnosisRequestModel model,required int id}) async {
    return await showFileRepository.updateDiagnosis(model: model,id: id);
  }

//   -----------------------------------------------------------

  Future<Either> getDrugs({required int id}) async {
    return await showFileRepository.getDrugs(id: id);
  }

  Future<Either> deleteDrugs({required int id}) async {
    return await showFileRepository.deleteDrugs(id: id);
  }

  Future<Either> addDrug({required AddDrugRequestModel model}) async {
    return await showFileRepository.addDrug(model: model);
  }

  Future<Either> updateDrug({required UpdateDrugRequestModel model,required int id}) async {
    return await showFileRepository.updateDrug(model: model,id: id);
  }

  //   ---------------------------------- Notes

  Future<Either> getNotes({required int id}) async {
    return await showFileRepository.getNotes(id: id);
  }

  Future<Either> deleteNote({required int id}) async {
    return await showFileRepository.deleteNote(id: id);
  }

  Future<Either> addNote({required AddNoteRequestModel model}) async {
    return await showFileRepository.addNote(model: model);
  }

  Future<Either> updateNote({required UpdateNoteRequestModel model,required int id}) async {
    return await showFileRepository.updateNote(model: model,id: id);
  }

  //   ---------------------------------- Notes

  Future<Either> getConsultations({required int id}) async {
    return await showFileRepository.getConsultations(id: id);
  }

  Future<Either> addConsultation({required AddConsultationRequestModel model}) async {
    return await showFileRepository.addConsultation(model: model);
  }

}
