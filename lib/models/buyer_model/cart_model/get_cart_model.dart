class GetCartModel {
  bool? status;
  String? msg;
  List<GetCartData>? data;
  
  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <GetCartData>[];
      json['data'].forEach((v) {
        data!.add(GetCartData.fromJson(v));
      });
    }
  }

}

class GetCartData {
  int? id;
  int? productId;
  String? name;
  String? firstImage;
  int? stock;
  int? piecePrice;
  int? quantityPrice;
  int? qty;
  bool? priceChanged;
  bool? stockChanged;


  GetCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    firstImage = json['first_image'];
    stock = json['stock'];
    piecePrice = json['piece_price'];
    quantityPrice = json['quantity_price'];
    qty = json['qty'];
    priceChanged = json['price_changed'];
    stockChanged = json['stock_changed'];
  }

}
