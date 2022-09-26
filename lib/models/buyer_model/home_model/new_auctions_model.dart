import '../product_model/images_model.dart';

class NewAuction {
  int? id;
  String? auctionName;
  String? productName;
  String? productDesc;
  int? auctionOpeningPrice;
  int? auctionJoiningCoins;
  int? remainingTime;
  int? categoryId;
  List<Images>? images;

  NewAuction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    auctionName = json['auction_name'];
    productName = json['product_name'];
    productDesc = json['product_desc'];
    auctionOpeningPrice = json['auction_opening_price'];
    auctionJoiningCoins = json['auction_joining_coins'];
    remainingTime = json['remaining_time'];
    categoryId = json['category_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

}
