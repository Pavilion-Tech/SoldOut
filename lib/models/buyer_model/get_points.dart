class GetPointsModel {
  bool? status;
  String? msg;
  List<GetPointsData>? data;


  GetPointsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <GetPointsData>[];
      json['data'].forEach((v) {
        data!.add( GetPointsData.fromJson(v));
      });
    }
  }


}

class GetPointsData {
  int? id;
  String? name;
  int? price;
  int? coinsNum;


  GetPointsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    coinsNum = json['coins_num'];
  }


}
