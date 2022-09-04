import 'package:soldout/models/buyer_model/product_model/product_model.dart';

class GetFavModel {
  bool? status;
  String? msg;
  GetFavData? data;


  GetFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? GetFavData.fromJson(json['data']) : null;
  }


}

class GetFavData {
  List<ProductModel>? products;
  int? count;
  int? perPage;
  int? currentPage;
  int? lastPage;


  GetFavData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

}


