class NotificationResponseModel {
  NotificationParentModel? model;

  NotificationResponseModel({this.model});

  NotificationResponseModel fromMap(Map<String, dynamic> json) {
    model = json['model'] != null ? NotificationParentModel.fromMap(json['model']) : null;
    return NotificationResponseModel(model:model);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.toMap();
    }
    return data;
  }
}

class  NotificationParentModel {
  List<NotificationModel>? today;
  List<NotificationModel>? yesterday;
  List<NotificationModel>? older;

  NotificationParentModel({this.today, this.yesterday, this.older});

  NotificationParentModel.fromMap(Map<String, dynamic> json) {
    if (json['today'] != null) {
      today = <NotificationModel>[];
      json['today'].forEach((v) {
        today!.add( NotificationModel().fromMap(v));
      });
    }
    if (json['yesterday'] != null) {
      yesterday = <NotificationModel>[];
      json['yesterday'].forEach((v) {
        yesterday!.add(NotificationModel().fromMap(v));
      });
    }
    if (json['older'] != null) {
      older = <NotificationModel>[];
      json['older'].forEach((v) {
        older!.add(NotificationModel().fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (today != null) {
      data['today'] = today!.map((v) => v.toMap()).toList();
    }
    if (yesterday != null) {
      data['yesterday'] = yesterday!.map((v) => v.toMap()).toList();
    }
    if (this.older != null) {
      data['older'] = older!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class NotificationModel {
  int? id;
  String? title;
  String? message;
  String? type;
  String? createdAt;
  bool? isRead;

  NotificationModel(
      {this.id,
        this.title,
        this.message,
        this.type,
        this.createdAt,
        this.isRead});

  NotificationModel fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
    return NotificationModel(id:id,title:title,type: type,createdAt: createdAt,isRead: isRead,message: message);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['is_read'] = this.isRead;
    return data;
  }
}