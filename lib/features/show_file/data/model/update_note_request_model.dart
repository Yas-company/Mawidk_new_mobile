class UpdateNoteRequestModel {
  int? patientId;
  String? date;
  String? title;
  String? note;

  UpdateNoteRequestModel({
    this.patientId,
    this.date,
    this.title,
    this.note,
  });

  UpdateNoteRequestModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'] as int?;
    date = json['date'] as String?;
    title = json['title'] as String?;
    note = json['note'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      if (patientId != null) 'patient_id': patientId,
      if (date != null) 'date': date,
      if (title != null) 'title': title,
      if (note != null) 'note': note,
    };
  }
}
