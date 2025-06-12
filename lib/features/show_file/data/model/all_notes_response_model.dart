class AllNotesResponseModel {
  final List<NotesData>? model;

  AllNotesResponseModel({
    this.model,
  });

  AllNotesResponseModel fromMap(Map<String, dynamic> map) {
    return AllNotesResponseModel(
      model: map['model'] != null
          ? List<NotesData>.from(
        (map['model']).map<NotesData?>(
              (x) => NotesData().fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }
}

class NotesData {
  final int? id;
  final String? title;
  final String? note;
  final String? date;



  NotesData({
    this.id,
    this.title,
    this.note,
    this.date,
  });

  NotesData fromMap(Map<String, dynamic> json) {
    return NotesData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      date: json['date'] as String?,
      note: json['note'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date,
    };
  }
}

