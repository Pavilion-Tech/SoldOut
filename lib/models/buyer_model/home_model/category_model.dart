import '../product_model/product_model.dart';

class CategoryModel {
  int? id;
  String? name;
  String? logo;
  String? hexColor;
  List<ProductModel>? products;


  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    hexColor = json['hex_color'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }

}



