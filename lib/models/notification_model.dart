class NotificationModel {
  bool? status;
  String? msg;
  List<NotificationData>? data;


  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add( NotificationData.fromJson(v));
      });
    }
  }


}

class NotificationData {
  int? id;
  String? title;
  String? body;
  int? redirectType;
  int? redirectId;
  int? createdAt;

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    redirectType = json['redirect_type'];
    redirectId = json['redirect_id'];
    createdAt = json['created_at'];
  }

}
