import 'dart:convert';
class BannerResponseModel {
  List<BannerData>? model;

  BannerResponseModel({
    this.model,
  });

  BannerResponseModel copyWith({
    List<BannerData>? model,
  }) {
    return BannerResponseModel(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model?.map((x) => x.toMap()).toList(),
    };
  }

  BannerResponseModel fromMap(Map<String, dynamic> map) {
    return BannerResponseModel(
      model: map['model'] != null
          ? List<BannerData>.from(
        (map['model']).map<BannerData?>(
              (x) => BannerData.fromMap(x as Map<String, dynamic>),
        ),
      ) : null,
    );
  }

  BannerResponseModel fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);
}


class BannerData {
  final String? image;

  BannerData({
    this.image
  });

  factory BannerData.fromMap(Map<String, dynamic> json) {
    return BannerData(
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }
}
