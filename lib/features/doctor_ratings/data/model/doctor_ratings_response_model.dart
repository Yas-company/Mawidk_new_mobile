import 'dart:convert';
class DoctorRatingsResponseModel {
  List<DoctorRating>? model;

  DoctorRatingsResponseModel({
    this.model,
  });

  DoctorRatingsResponseModel copyWith({
    List<DoctorRating>? model,
  }) {
    return DoctorRatingsResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  DoctorRatingsResponseModel fromMap(Map<String, dynamic> map) {
    return DoctorRatingsResponseModel(
      model: map['model'] != null
          ? List<DoctorRating>.from(
        (map['model']).map<DoctorRating?>(
              (x) => DoctorRating.fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  DoctorRatingsResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}


class DoctorRating {
  final int? id;
  final Patient? patient;
  final dynamic rating;
  final String? comment;
  final String? createdAt;

  DoctorRating({
    this.id,
    this.patient,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory DoctorRating.fromMap(Map<String, dynamic> json) {
    return DoctorRating(
      id: json['id'] as int?,
      patient: Patient.fromMap(json['patient']),
      rating: json['rating'] as dynamic,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient': patient!.toMap(),
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
    };
  }
}

class Patient {
  final int? id;
  final String? name;
  final String? photo;

  Patient({ this.id,  this.name,this.photo});

  factory Patient.fromMap(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as int?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'name': name,
    };
  }
}


