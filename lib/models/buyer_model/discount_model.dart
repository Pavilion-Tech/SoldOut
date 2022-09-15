class DiscountModel {
  bool? status;
  String? msg;
  Data? data;



  DiscountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? subTotal;
  int? discountMoney;
  int? totalShippingCharges;
  int? totalCartPrice;



  Data.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    discountMoney = json['discount_money'];
    totalShippingCharges = json['total_shipping_charges'];
    totalCartPrice = json['total_cart_price'];
  }


}
