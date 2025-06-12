class AddNoteRequestModel {
  int? patientId;
  String? date;
  String? title;
  String? note;

  AddNoteRequestModel({
    this.patientId,
    this.date,
    this.title,
    this.note,
  });

  AddNoteRequestModel.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'] as int?;
    date = json['date'] as String?;
    title = json['title'] as String?;
    note = json['note'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'date': date,
      'title': title,
      'note': note,
    };
  }
}
