class FavouriteDoctorListResponseModel {
  List<FavouriteDoctorListData>? model;

  FavouriteDoctorListResponseModel({this.model});

  FavouriteDoctorListResponseModel fromMap(Map<String, dynamic> json) {
    if (json['model'] != null) {
      model = <FavouriteDoctorListData>[];
      json['model'].forEach((v) {
        model!.add(FavouriteDoctorListData().fromMap(v));
      });
    }
    return FavouriteDoctorListResponseModel(model: model);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class FavouriteDoctorListData {
  int? id;
  Doctor? doctor;

  FavouriteDoctorListData({this.id, this.doctor});

  FavouriteDoctorListData fromMap(Map<String, dynamic> json) {
    id = json['id'];
    doctor =
    json['doctor'] != null ? Doctor().fromMap(json['doctor']) : null;
    return FavouriteDoctorListData(id: id,doctor: doctor);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (this.doctor != null) {
      data['doctor'] = doctor!.toMap();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? name;
  String? photo;
  String? specialization;

  Doctor({this.id, this.name, this.photo, this.specialization});

  Doctor fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    specialization = json['specialization'];
    return Doctor(id: id,name: name,photo: photo,specialization: specialization);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['specialization'] = specialization;
    return data;
  }
}