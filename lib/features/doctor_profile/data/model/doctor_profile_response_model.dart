class DoctorProfileResponseModel {
  final DoctorModel? model;

  DoctorProfileResponseModel({
    this.model,
  });

  DoctorProfileResponseModel fromMap(Map<String, dynamic> json) {
    return DoctorProfileResponseModel(
      model: json['model'] != null ? DoctorModel.fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class DoctorModel {
  final int? id;
  final String? name;
  final String? photo;
  final String? specialization;
  final double? averageRating;
  final int? ratingsCount;
  final bool? isFavorite;
  final int? yearsOfExperience;
  final int? commentsCount;
  final int? countOfPatients;
  final String? aboutDoctor;
  final List<Subspeciality>? subspecialities;
  final List<Ratings>? ratings;

  DoctorModel({
    this.id,
    this.name,
    this.photo,
    this.specialization,
    this.averageRating,
    this.isFavorite,
    this.ratingsCount,
    this.countOfPatients,
    this.yearsOfExperience,
    this.aboutDoctor,
    this.commentsCount,
    this.ratings,
    this.subspecialities,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      commentsCount: json['comments_count'],
      countOfPatients: json['count_of_ptients'],
      isFavorite: json['is_favorite'],
      name: json['name'],
      photo: json['photo'],
      specialization: json['specialization'],
      averageRating: (json['average_rating'] as num).toDouble(),
      ratingsCount: json['ratings_count'],
      yearsOfExperience: json['years_of_experience'],
      aboutDoctor: json['about_doctor'],
      subspecialities: json['subspecialities']!=null?((json['subspecialities'] as List<dynamic>)
          .map((e) => Subspeciality.fromMap(e))
          .toList()):[],
      ratings: json['ratings']!=null?((json['ratings'] as List<dynamic>)
          .map((e) => Ratings.fromMap(e))
          .toList()) : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comments_count': commentsCount,
      'count_of_ptients': countOfPatients,
      'name': name,
      'photo': photo,
      'is_favorite': isFavorite,
      'specialization': specialization,
      'average_rating': averageRating,
      'ratings_count': ratingsCount,
      'years_of_experience': yearsOfExperience,
      'about_doctor': aboutDoctor,
      'subspecialities': subspecialities!=null?subspecialities?.map((e) => e.toMap()).toList():[],
      'ratings': ratings!=null?ratings?.map((e) => e.toMap()).toList():[],
    };
  }
}

class Subspeciality {
  final int id;
  final String name;

  Subspeciality({required this.id, required this.name});

  factory Subspeciality.fromMap(Map<String, dynamic> json) {
    return Subspeciality(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Ratings {
  final int? id;
  final String? comments;
  final String? comment;
  final String? createdAt;
  final dynamic rate;
  final Patient? patient;

  Ratings({ this.id, this.comments, this.rate,this.patient,this.createdAt,
  this.comment});

  factory Ratings.fromMap(Map<String, dynamic> json) {
    return Ratings(
      id: json['id'],
      comments: json['comments'],
      comment: json['comment'],
      createdAt: json['created_at'],
      rate: json['rate'],
      patient: Patient.fromMap(json['patient']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'comments': comments,
      'rate': rate,
      'comment': comment,
      'patient': patient!.toMap(),
    };
  }
}

class Patient {
  final int? id;
  final String? name;
  final String? photo;

  Patient({ this.id, this.photo, this.name});

  factory Patient.fromMap(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
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