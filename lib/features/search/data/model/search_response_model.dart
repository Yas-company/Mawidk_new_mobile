import 'dart:convert';
class SearchResponseModel {
  List<SearchData>? model;

  SearchResponseModel({
    this.model,
  });

  SearchResponseModel copyWith({
    List<SearchData>? model,
  }) {
    return SearchResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  SearchResponseModel fromMap(Map<String, dynamic> map) {
    return SearchResponseModel(
      model: map['model'] != null
          ? List<SearchData>.from(
        (map['model']).map<SearchData?>(
              (x) => SearchData.fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  SearchResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}


class SearchData {
  final int? id;
  final num? averageRating;
  final String? name;
  final String? image;
  final String? specialization;
  final int? experience;
  final String? gender;
  final String? licenseNumber;
  final String? typeOfDoctor;

  SearchData({
    this.id,
    this.image,
    this.name,
    this.averageRating,
    this.specialization,
    this.experience,
    this.typeOfDoctor,
    this.gender,
    this.licenseNumber,
  });

  factory SearchData.fromMap(Map<String, dynamic> json) {
    return SearchData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      averageRating: json['average_rating'] as num?,
      typeOfDoctor: json['type_of_doctor'] as String?,
      image: json['image'] as String?,
      specialization: json['specialization'] as String?,
      experience: json['experience'] as int?,
      gender: json['gender'] as String?,
      licenseNumber: json['license_number'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'average_rating': averageRating,
      'image': image,
      'specialization': specialization,
      'experience': experience,
      'type_of_doctor': typeOfDoctor,
      'gender': gender,
      'license_number': licenseNumber,
    };
  }
}
