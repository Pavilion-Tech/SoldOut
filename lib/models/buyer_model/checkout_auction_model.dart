class CheckOutAuctionModel {
  bool? status;
  String? msg;
  CheckOutAuctionData? data;


  CheckOutAuctionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new CheckOutAuctionData.fromJson(json['data']) : null;
  }


}

class CheckOutAuctionData {
  int? id;
  String? auctionName;
  String? productName;
  String? productDesc;
  String? firstImage;
  int? subTotal;
  int? shippingCharges;
  int? totalPrice;


  CheckOutAuctionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auctionName = json['auction_name'];
    productName = json['product_name'];
    productDesc = json['product_desc'];
    firstImage = json['first_image'];
    subTotal = json['sub_total'];
    shippingCharges = json['shipping_charges'];
    totalPrice = json['total_price'];
  }


}
