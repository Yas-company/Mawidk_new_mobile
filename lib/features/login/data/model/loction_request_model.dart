class LocationRequestModel {
  final double latitude;
  final double longitude;

  LocationRequestModel({
    required this.latitude,
    required this.longitude,
  });

  factory LocationRequestModel.fromJson(Map<String, dynamic> json) {
    return LocationRequestModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
