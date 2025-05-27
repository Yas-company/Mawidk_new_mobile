class UpdatePhotoResponseModel {
  final UpdatePhotoData? model;

  UpdatePhotoResponseModel({
    this.model,
  });

  UpdatePhotoResponseModel fromMap(Map<String, dynamic> json) {
    return UpdatePhotoResponseModel(
      model: json['model'] != null ? UpdatePhotoData.fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class UpdatePhotoData {
  final int? id;
  final String? name;
  final String? photo;

  UpdatePhotoData({
    this.id,this.name,this.photo
  });

  factory UpdatePhotoData.fromMap(Map<String, dynamic> json) {
    return UpdatePhotoData(
      id: json['id'],
      name: json['name'],
      photo: json['photo_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo_url': photo,
    };
  }
}
