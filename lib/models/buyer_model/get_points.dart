class GetPointsModel {
  bool? status;
  String? msg;
  GetPointsData? data;


  GetPointsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? GetPointsData.fromJson(json['data']) : null;
  }

}

class GetPointsData {
  int? leftCoins;
  int? lastPackageCoins;
  List<Packages>? packages;


  GetPointsData.fromJson(Map<String, dynamic> json) {
    leftCoins = json['left_coins'];
    lastPackageCoins = json['last_package_coins'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

}

class Packages {
  int? id;
  String? name;
  int? price;
  int? coinsNum;


  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    coinsNum = json['coins_num'];
  }
}
