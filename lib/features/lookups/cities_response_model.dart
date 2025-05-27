import 'dart:convert';
class CitiesResponseModel {
  List<CitiesData>? model;

  CitiesResponseModel({
    this.model,
  });

  CitiesResponseModel copyWith({
    List<CitiesData>? model,
  }) {
    return CitiesResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  CitiesResponseModel fromMap(Map<String, dynamic> map) {
    return CitiesResponseModel(
      model: map['model'] != null
          ? List<CitiesData>.from(
        (map['model']).map<CitiesData?>(
              (x) => CitiesData.fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  CitiesResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}


class CitiesData {
  final int? id;
  final String? name;

  CitiesData({
    this.id,
    this.name,
  });

  factory CitiesData.fromMap(Map<String, dynamic> json) {
    return CitiesData(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
