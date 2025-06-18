import 'package:mawidak/features/show_file/data/model/add_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/consultation/add_consultation_request_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/add_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/add_note_request_model.dart';
import 'package:mawidak/features/show_file/data/model/drug/update_drug_request_model.dart';
import 'package:mawidak/features/show_file/data/model/update_diagnosis_request_model.dart';
import 'package:mawidak/features/show_file/data/model/update_note_request_model.dart';

abstract class ShowFileEvent {
  const ShowFileEvent();
}

class ApplyBasicInfo extends ShowFileEvent {
  final int id;
  const ApplyBasicInfo({required this.id}) : super();
}

class ApplyMedicalHistory extends ShowFileEvent {
  final int id;
  const ApplyMedicalHistory({required this.id}) : super();
}

// ________________________________________
class ApplyDiagnosis extends ShowFileEvent {
  final int id;
  const ApplyDiagnosis({required this.id}) : super();
}

class ApplyAddingDiagnosis extends ShowFileEvent {
  final AddDiagnosisRequestModel addDiagnosisRequestModel;
  const ApplyAddingDiagnosis({required this.addDiagnosisRequestModel}) : super();
}

class ApplyEditingDiagnosis extends ShowFileEvent {
  final UpdateDiagnosisRequestModel updateDiagnosisRequestModel;
  final int id;
  const ApplyEditingDiagnosis({required this.updateDiagnosisRequestModel, required this.id}) : super();
}
// _____________________________________________


// ________________________________________________ Drug

class ApplyDrugs extends ShowFileEvent {
  final int id;
  const ApplyDrugs({required this.id}) : super();
}

class ApplyAddingDrugs extends ShowFileEvent {
  final AddDrugRequestModel addDrugRequestModel;
  const ApplyAddingDrugs({required this.addDrugRequestModel}) : super();
}

class ApplyEditingDrugs extends ShowFileEvent {
  final UpdateDrugRequestModel updateDrugRequestModel;
  final int id;
  const ApplyEditingDrugs({required this.updateDrugRequestModel, required this.id}) : super();
}

class ApplyDeleteDrugs extends ShowFileEvent {
  final int id;
  const ApplyDeleteDrugs({required this.id}) : super();
}

// ___________________________________________________  Notes

class ApplyNotes extends ShowFileEvent {
  final int id;
  const ApplyNotes({required this.id}) : super();
}

class ApplyAddingNote extends ShowFileEvent {
  final AddNoteRequestModel addNoteRequestModel;
  const ApplyAddingNote({required this.addNoteRequestModel}) : super();
}

class ApplyEditingNote extends ShowFileEvent {
  final UpdateNoteRequestModel updateNoteRequestModel;
  final int id;
  const ApplyEditingNote({required this.updateNoteRequestModel, required this.id}) : super();
}

class ApplyDeleteNote extends ShowFileEvent {
  final int id;
  const ApplyDeleteNote({required this.id}) : super();
}

// ___________________________________________________  Consultation

class ApplyConsultations extends ShowFileEvent {
  final int id;
  const ApplyConsultations({required this.id}) : super();
}

class ApplyAddingConsultation extends ShowFileEvent {
  final AddConsultationRequestModel addConsultationRequestModel;
  const ApplyAddingConsultation({required this.addConsultationRequestModel}) : super();
}

class ApplyConsultationById extends ShowFileEvent {
  final int id;
  const ApplyConsultationById({required this.id}) : super();
}