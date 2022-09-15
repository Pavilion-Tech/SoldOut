class OrderModel {
  bool? status;
  String? msg;
  List<OrderData>? data;

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

}

class OrderData {
  int? id;
  String? shippingAddress;
  bool? isPaid;
  int? paymentMethod;
  int? subTotal;
  int? totalShippingCharges;
  int? totalOrderPrice;
  int? createdAt;
  List<Stores>? stores;


  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingAddress = json['shipping_address'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    subTotal = json['sub_total'];
    totalShippingCharges = json['total_shipping_charges'];
    totalOrderPrice = json['total_order_price'];
    createdAt = json['created_at'];
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
  }

}

class Stores {
  int? id;
  String? name;
  String? status;
  String? devStatus;
  int? countProducts;
  int? shippingCharges;
  List<Products>? products;


  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    devStatus = json['dev_status'];
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
