class FilterRequestModel {
  final int specializationId;
  final int cityId;

  FilterRequestModel({
    required this.specializationId,
    required this.cityId,
  });

  factory FilterRequestModel.fromJson(Map<String, dynamic> json) {
    return FilterRequestModel(
      specializationId: json['specialization_id'],
      cityId: json['city_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialization_id': specializationId,
      'city_id': cityId,
    };
  }
}
