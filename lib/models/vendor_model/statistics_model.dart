class GetStatistics {
  bool? status;
  String? msg;
  Data? data;


  GetStatistics.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? productsCount;
  int? ordersCount;
  int? totalRevenue;


  Data.fromJson(Map<String, dynamic> json) {
    productsCount = json['products_count'];
    ordersCount = json['orders_count'];
    totalRevenue = json['total_revenue'];
  }

}
