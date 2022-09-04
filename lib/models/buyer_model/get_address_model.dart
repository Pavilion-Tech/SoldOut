class GetAddressModel {
  bool? status;
  String? msg;
  List<GetAddressData>? data;


  GetAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <GetAddressData>[];
      json['data'].forEach((v) {
        data!.add(GetAddressData.fromJson(v));
      });
    }
  }


}

class GetAddressData {
  int? id;
  String? title;
  String? address;
  int? neighborhoodId;
  int? cityId;
  String? fullAddress;


  GetAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    neighborhoodId = json['neighborhood_id'];
    cityId = json['city_id'];
    fullAddress = json['full_address'];
  }

}
