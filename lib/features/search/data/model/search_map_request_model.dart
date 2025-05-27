class SearchMapRequestModel {
  final double latitude;
  final double longitude;

  SearchMapRequestModel({
    required this.latitude,
    required this.longitude,
  });

  factory SearchMapRequestModel.fromJson(Map<String, dynamic> json) {
    return SearchMapRequestModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
