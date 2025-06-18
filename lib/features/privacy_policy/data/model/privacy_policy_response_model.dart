class PrivacyPolicyResponseModel {
  final PrivacyPolicyData? model;

  PrivacyPolicyResponseModel({
    this.model,
  });

  PrivacyPolicyResponseModel fromMap(Map<String, dynamic> json) {
    return PrivacyPolicyResponseModel(
      model: json['model'] != null ? PrivacyPolicyData().fromMap(json['model']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model?.toMap(),
    };
  }
}

class PrivacyPolicyData {
  final int? id;
  final String? title;
  final String? content;

  PrivacyPolicyData({
    this.id,
    this.title,
    this.content,
  });

  PrivacyPolicyData fromMap(Map<String, dynamic> json) {
    return PrivacyPolicyData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}

