import 'package:soldout/models/buyer_model/home_model/new_auctions_model.dart';

class MyAuctionsModel {
  bool? status;
  String? msg;
  List<AuctionModel>? data;


  MyAuctionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AuctionModel>[];
      json['data'].forEach((v) {
        data!.add( AuctionModel.fromJson(v));
      });
    }
  }

}




