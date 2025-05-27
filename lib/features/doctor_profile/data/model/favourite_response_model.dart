class FavouriteResponseModel {
  final FavouriteData? model;

  FavouriteResponseModel({
    this.model,
  });

  FavouriteResponseModel fromMap(Map<String, dynamic> json) {
    return FavouriteResponseModel(
      model: json['model'] != null ? FavouriteData.fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class FavouriteData {
  final bool? isFavorite;

  FavouriteData({
    this.isFavorite,
  });

  factory FavouriteData.fromMap(Map<String, dynamic> json) {
    return FavouriteData(
      isFavorite: json['is_favorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_favorite': isFavorite,
    };
  }
}
