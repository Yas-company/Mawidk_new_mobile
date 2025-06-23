class SearchMapResponseModel {
  final List<ClinicData>? model;

  SearchMapResponseModel({
    this.model,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  SearchMapResponseModel fromMap(Map<String, dynamic> map) {
    return SearchMapResponseModel(
      model: map['model'] != null
          ? List<ClinicData>.from(
        (map['model']).map<ClinicData?>(
              (x) => ClinicData.fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }
}

class ClinicData {
  final int? id;
  final String? name;
  final String? specialization;
  final String? image;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? doctorType;
  final num? averageRating;
  final String? workingHoursFrom;
  final String? workingHoursTo;
  final List<String>? workingDays;
  final String? consultationFee;
  final String? doctorName;
  final dynamic distance;

  ClinicData({
    this.id,
    this.name,
    this.specialization,
    this.address,
    this.image,
    this.doctorType,
    this.averageRating,
    this.latitude,
    this.longitude,
    this.workingHoursFrom,
    this.workingHoursTo,
    this.workingDays,
    this.consultationFee,
    this.doctorName,
    this.distance,
  });
  //
  // ClinicData fromMap(Map<String, dynamic> json) {
  //   return ClinicData(
  //     id: json['id'],
  //     name: json['name'],
  //     address: json['address'],
  //     latitude: json['latitude'],
  //     longitude: json['longitude'],
  //     workingHoursFrom: json['working_hours_from'],
  //     workingHoursTo: json['working_hours_to'],
  //     workingDays: List<String>.from(json['working_days']),
  //     consultationFee: json['consultation_fee'],
  //     doctorName: json['doctor_name'],
  //     distance: json['distance'],
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'image': image,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'type_of_doctor': doctorType,
      'average_rating': averageRating,
      'working_hours_from': workingHoursFrom,
      'working_hours_to': workingHoursTo,
      'working_days': workingDays,
      'consultation_fee': consultationFee,
      'doctor_name': doctorName,
      'distance': distance,
    };
  }


  factory ClinicData.fromMap(Map<String, dynamic> json) {
    return ClinicData(
      id: json['id'] as int?,
      distance: json['distance'] as dynamic,
      name: json['name'] as String?,
      doctorType: json['type_of_doctor'] as String?,
      averageRating: json['average_rating'] as num?,
      specialization: json['specialization'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      workingHoursFrom: json['working_hours_from'] as String?,
      workingHoursTo: json['working_hours_to'] as String?,
      consultationFee: json['consultation_fee'] as String?,
      doctorName: json['doctorName'] as String?,
      workingDays: List<String>.from(json['working_days']),
    );
  }

}

