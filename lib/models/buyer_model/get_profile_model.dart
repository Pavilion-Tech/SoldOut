class GetProfileModel {
  bool? status;
  String? msg;
  GetProfileData? data;


  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ?  GetProfileData.fromJson(json['data']) : null;
  }


}

class GetProfileData {
  int? id;
  String? name;
  String? phone;
  String? accessToken;


  GetProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    accessToken = json['access_token'];
  }


}
