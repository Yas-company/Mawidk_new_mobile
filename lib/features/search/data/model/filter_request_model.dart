class FilterRequestModel {
  final int specializationId;
  final int cityId;
  final int typeOfDoctor;
  final num rating;

  FilterRequestModel({
    required this.specializationId,
    required this.cityId,
    required this.typeOfDoctor,
    required this.rating,
  });

  factory FilterRequestModel.fromJson(Map<String, dynamic> json) {
    return FilterRequestModel(
      specializationId: json['specialization_id'],
      cityId: json['city_id'],
      typeOfDoctor: json['type_of_doctor'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialization_id': specializationId,
      'city_id': cityId,
      'type_of_doctor': typeOfDoctor,
      'rating': rating,
    };
  }
}
