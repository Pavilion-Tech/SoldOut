import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/points.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import '../../../../../models/buyer_model/checkout_auction_model.dart';
import '../../../../../models/buyer_model/home_model/new_auctions_model.dart';
import '../../../../../models/buyer_model/my_auction_model.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../../shared/network/remote/end_point.dart';
import '../../../widgets/paymen/payment.dart';
import 'auction_states.dart';

class AuctionCubit extends Cubit<AuctionStates>
{
  AuctionCubit():super(InitState());

  static AuctionCubit get (context)=> BlocProvider.of(context);

  List<AuctionModel>? categoryAuctions;

  MyAuctionsModel? myAuction;

  AuctionModel? auctionModel;

  List<AuctionModel>? searchModel;

  CheckOutAuctionModel? checkOutAuctionModel;

  Map<String , dynamic> map ={};

  Duration duration = const Duration();

  bool isUserJoined = true;

  void changeAuctionHint() {
    showAuctionHint = true;
    emit(ChangeAuctionHintState());
    CacheHelper.saveData(key: 'showAuctionHint', value: true);
  }

  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }

  void currentCategory(List<AuctionModel> currentAuction,int index)
  {
    categoryAuctions = [];
    emit(ChangeCategoryLoading());
    for (var auction in currentAuction)
    {
      if(auction.categoryId == index)
      {
        categoryAuctions!.add(auction);
      }
    }
    emit(ChangeCategorySuccess());
  }

  void justEmit()
  {
    emit(JustEmitState());
  }

  void myAuctions()async
  {
    emit(AuctionLoading());
    await DioHelper.getData(
      url: auction,
      token: 'Bearer $token',
      lang: myLocale
    ).then((value) {
      if(value.statusCode == 200&&value.data['status'])
      {
        myAuction = MyAuctionsModel.fromJson(value.data);
        emit(AuctionSuccess());
      }else
        {
          showToast(msg: tr('wrong'),toastState: true);
          emit(AuctionWrong());
        }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(AuctionError());
    });
  }

  void joinAuctions(int id,context)async
  {
    emit(AuctionLoading());
    await DioHelper.postData(
        url: auction,
        token: 'Bearer $token',
        lang: myLocale,
        data: {
          'auction_id':id
        }
    ).then((value) {
      if(value.statusCode == 200&&value.data['status'])
      {
        isUserJoined = true;
        showToast(msg: tr('joined'));
        emit(AuctionSuccess());
      }else if (value.data!=null&&!value.data['status'])
        {
          showToast(msg: value.data['errors'].toString(),toastState: true);
          if(value.data['have_points']!=null)
          {
              navigateTo(context,const PointsScreen());
          }
          emit(AuctionWrong());
        }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: true);
      emit(AuctionError());
    });
  }

  void bid(int id,context)async
  {
    await DioHelper.postData(
        url: makeBid,
        token: 'Bearer $token',
        lang: myLocale,
        data: {
          'auction_id':id
        }
    ).then((value) {
      print(value.data);
      if (value.data!=null&&!value.data['status'])
        {
          showToast(msg: value.data['errors'].toString(),toastState: true);
          if(value.data['have_points']!=null)
          {
            navigateTo(context,const PointsScreen());
          }
          emit(AuctionWrong());
        }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: true);
      emit(AuctionError());
    });
  }


  final pusher = PusherChannelsFlutter.getInstance();

  void initPusher() async {
    await pusher.init(
        apiKey: '473da60c01747f5e3770',
        cluster: 'mt1',
        onConnectionStateChange: onConnectionStateChange
    );
    await pusher.connect();
  }

  void subscribePusher(int id) async {
    await pusher.subscribe(
      channelName: "auction.$id",
      onEvent: onEvent,
      onSubscriptionSucceeded: (dynamic data) {
        print("onSubscriptionSucceeded:  data: $data");
      },
      onSubscriptionError: (dynamic e) {
        print("Exception: $e");
      },
    );
  }

  void unsubscribePusher(int id) async {
    await pusher.unsubscribe(channelName: "auction.$id");
    emit(UnsubscribePusher());
  }

  onEvent(dynamic event) {
    try{
      Map<String,dynamic> valueMap = json.decode(event.data);
      print(valueMap);
      if(valueMap.isNotEmpty){
        auctionModel = AuctionModel.fromJson(valueMap);
        duration = Duration(milliseconds: auctionModel!.remainingTime!);
        isUserJoined = auctionModel!.isUserJoined!;
        emit(AuctionUpdated());
      }
    }catch(e){
      print(e.toString());
      showToast(msg: tr('wrong'),toastState: true);
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void search(String text)
  {
    searchModel = [];
    for(var auction in myAuction!.data!)
    {
      if(auction.auctionName!.contains(text)){
        searchModel!.add(auction);
      }
    }
    emit(SearchState());
  }

  void nullSearch()
  {
    searchModel = null;
    emit(SearchState());
  }

  void sort(int select)
  {
    searchModel = [];
    if(select == 0)
    {
      for(var auction in myAuction!.data!)
      {
        if(auction.status == 'processing'){
          searchModel!.add(auction);
        }
      }
    }
    if(select == 1)
    {
      for(var auction in myAuction!.data!)
      {
        if(auction.status == 'finished'){
          searchModel!.add(auction);
        }
      }
    }
    emit(SearchState());
  }


  void getCheckOut(int id)async
  {
    emit(CheckOutAuctionLoading());
    await DioHelper.getData(
        url: '$auctionFetchCheckOut$id',
        token: 'Bearer $token',
        lang: myLocale,
    ).then((value) {
      if(value.statusCode == 200&&value.data['status'])
      {
        checkOutAuctionModel = CheckOutAuctionModel.fromJson(value.data);
        emit(CheckOutAuctionSuccess());
      }else
        {
          showToast(msg: tr('wrong'));
        }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: true);
      emit(CheckOutAuctionError());
    });
  }

  void checkOut({
    String? couponCode,
    String? address,
    int? neighborhoodId,
    int? cityId,
    int? userAddressId,
    BuildContext? context,
  })async
  {
    checkOutData(
      id:checkOutAuctionModel!.data!.id,
      couponCode:couponCode,
      address:address,
      neighborhoodId:neighborhoodId,
      cityId:cityId,
      userAddressId: userAddressId,
    );
    emit(CheckOutAuctionLoading());
    await DioHelper.postData(
        url: auctionCheckOut,
        token: 'Bearer $token',
        lang: myLocale,
        data: map
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status'])
      {
        String link = value.data['data']['payment_link'];
        if(link.isNotEmpty)
        {
          navigateTo(context, Payment(url: link,));
        }
        emit(CheckOutAuctionSuccess());
      }else if (value.data!=null &&!value.data['status'])
      {
        showToast(msg: value.data['errors'].toString());
      }else
        {
          showToast(msg: tr('wrong'));
        }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: true);
      emit(CheckOutAuctionError());
    });
  }

  void checkOutData({
    int? id,
    String? couponCode,
    String? address,
    int? neighborhoodId,
    int? cityId,
    int? userAddressId,
  }){
    if(userAddressId == null){
      if(couponCode!.isNotEmpty){
        map = {
          'auction_id':id,
          'coupon_code':couponCode,
          'address':address,
          'neighborhood_id':neighborhoodId,
          'city_id':cityId,
        };
      }else{
        map = {
          'auction_id':id,
          'address':address,
          'neighborhood_id':neighborhoodId,
          'city_id':cityId,
        };
      }
    }else{
      if(couponCode!.isNotEmpty){
        map = {
          'auction_id':id,
          'coupon_code':couponCode,
          'user_address_id':userAddressId,
        };
      }else{
        map = {
          'auction_id':id,
          'user_address_id':userAddressId,
        };
      }
    }
  }

}