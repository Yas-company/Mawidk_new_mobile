class AddRateRequestModel {
   int? id;
   num? rate;
   String? comment;

  AddRateRequestModel({
     this.id,
     this.rate,
     this.comment,
  });

  factory AddRateRequestModel.fromJson(Map<String, dynamic> json) {
    return AddRateRequestModel(
      id: json['doctor_id'] as int,
      rate: json['rate'] as num,
      comment: json['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctor_id': id,
      'rate': rate,
      'comment': comment,
    };
  }
}
