class FavouriteRequestModel {
  int? doctorId;
  bool? isFavorite;

  FavouriteRequestModel({this.doctorId, this.isFavorite});

  FavouriteRequestModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['is_favorite'] = isFavorite;
    return data;
  }
}

