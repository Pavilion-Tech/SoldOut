class GetCheckOutModel {
  bool? status;
  String? msg;
  GetCheckOutData? data;


  GetCheckOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ?  GetCheckOutData.fromJson(json['data']) : null;
  }

}

class GetCheckOutData {
  List<Carts>? carts;
  int? subTotal;
  int? totalShippingCharges;
  int? totalCartPrice;

  GetCheckOutData.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(Carts.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    totalShippingCharges = json['total_shipping_charges'];
    totalCartPrice = json['total_cart_price'];
  }

}

class Carts {
  int? storeId;
  String? storeName;
  int? countProducts;
  int? shippingCharges;
  List<Products>? products;


  Carts.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    countProducts = json['count_products'];
    shippingCharges = json['shipping_charges'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

}

class Products {
  int? id;
  int? productId;
  String? name;
  String? firstImage;
  int? piecePrice;
  int? quantityPrice;
  int? qty;


  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    firstImage = json['first_image'];
    piecePrice = json['piece_price'];
    quantityPrice = json['quantity_price'];
    qty = json['qty'];
  }

}
