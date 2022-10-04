import 'package:soldout/models/buyer_model/home_model/ads_model.dart';
import '../product_model/product_model.dart';
import 'category_model.dart';
import 'new_auctions_model.dart';

class HomeModel {
  bool? status;
  String? msg;
  HomeData? data;


  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }

}

class HomeData {
  List<AdsModel>? ads;
  List<CategoryModel>? categories;
  List<ProductModel>? newProducts;
  List<AuctionModel>? newAuctions;


  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = <AdsModel>[];
      json['ads'].forEach((v) {
        ads!.add( AdsModel.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['new_products'] != null) {
      newProducts = <ProductModel>[];
      json['new_products'].forEach((v) {
        newProducts!.add(ProductModel.fromJson(v));
      });
    }
    if (json['new_auctions'] != null) {
      newAuctions = <AuctionModel>[];
      json['new_auctions'].forEach((v) {
        newAuctions!.add(AuctionModel.fromJson(v));
      });
    }
  }

}