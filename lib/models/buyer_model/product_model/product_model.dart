import 'package:soldout/models/buyer_model/product_model/review_model.dart';
import 'package:soldout/models/buyer_model/product_model/store_model.dart';
import 'images_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? desc;
  dynamic weight;
  dynamic regularPrice;
  dynamic salePrice;
  bool? onSale;
  dynamic stock;
  int? categoryId;
  bool? isFavourite;
  dynamic rate;
  dynamic numUsersRate;
  List<Images>? images;
  List<Reviews>? reviews;
  Store? store;


  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    weight = json['weight'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    onSale = json['on_sale'];
    stock = json['stock'];
    categoryId = json['category_id'];
    isFavourite = json['is_favourite'];
    rate = json['rate'];
    numUsersRate = json['num_users_rate'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

}





