class VendorOrderModel {
  bool? status;
  String? msg;
  List<VendorOrderData>? data;

  VendorOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <VendorOrderData>[];
      json['data'].forEach((v) {
        data!.add(VendorOrderData.fromJson(v));
      });
    }
  }

}

class VendorOrderData {
  int? id;
  String? shippingAddress;
  String? status;
  String? devStatus;
  int? countProducts;
  bool? isPaid;
  int? paymentMethod;
  int? subTotal;
  int? totalShippingCharges;
  int? totalOrderPrice;
  int? createdAt;
  User? user;
  List<Products>? products;

  VendorOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingAddress = json['shipping_address'];
    status = json['status'];
    devStatus = json['dev_status'];
    countProducts = json['count_products'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    subTotal = json['sub_total'];
    totalShippingCharges = json['total_shipping_charges'];
    totalOrderPrice = json['total_order_price'];
    createdAt = json['created_at'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add( Products.fromJson(v));
      });
    }
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? accessToken;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    accessToken = json['access_token'];
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
