import 'package:soldout/models/buyer_model/product_model/product_model.dart';

class ListProductModel {
  bool? status;
  String? msg;
  ListProductsData? data;


  ListProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? ListProductsData.fromJson(json['data']) : null;
  }

}

class ListProductsData {
  List<ProductModel>? products;
  int? count;
  int? perPage;
  int? currentPage;
  int? lastPage;


  ListProductsData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add( ProductModel.fromJson(v));
      });
    }
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

}


