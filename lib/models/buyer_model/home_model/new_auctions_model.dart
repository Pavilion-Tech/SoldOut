import '../product_model/images_model.dart';

class AuctionModel {
  int? id;
  String? auctionName;
  String? productName;
  String? productDesc;
  String? dateFrom;
  String? dateTo;
  int? auctionOpeningPrice;
  bool? isUserJoined;
  bool? isUserWinner;
  int? auctionJoiningCoins;
  int? remainingTime;
  int? categoryId;
  String? status;
  List<Images>? images;
  List<Bids>? bids;

  AuctionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    auctionName = json['auction_name'];
    productName = json['product_name'];
    productDesc = json['product_desc'];
    auctionOpeningPrice = json['auction_opening_price'];
    isUserJoined = json['is_user_joined'];
    isUserWinner = json['is_user_winner'];
    auctionJoiningCoins = json['auction_joining_coins'];
    remainingTime = json['remaining_time'];
    categoryId = json['category_id'];
    status = json['status'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add( Images.fromJson(v));
      });
    }
    if (json['bids'] != null) {
      bids = <Bids>[];
      json['bids'].forEach((v) {
        bids!.add( Bids.fromJson(v));
      });
    }

}
}


class Bids {
  int? id;
  String? userName;
  int? bidAmount;
  int? createdAt;


  Bids.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    bidAmount = json['bid_amount'];
    createdAt = json['created_at'];
  }


}
