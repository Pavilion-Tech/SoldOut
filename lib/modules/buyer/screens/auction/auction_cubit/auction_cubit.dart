import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../../models/buyer_model/home_model/new_auctions_model.dart';
import 'auction_states.dart';

class AuctionCubit extends Cubit<AuctionStates>
{
  AuctionCubit():super(InitState());



  static AuctionCubit get (context)=> BlocProvider.of(context);

  List<NewAuction>? categoryAuctions;

  void currentCategory(List<NewAuction> currentAuction,int index)
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


  PusherChannelsFlutter pusher = PusherChannelsFlutter();

  void initPusher() async {
    await pusher.init(
        apiKey: 'API_KEY',
        cluster: 'API_CLUSTER',
        onConnectionStateChange: onConnectionStateChange);
    await pusher.connect();
  }

  void subscribePusher() async {
    await pusher.subscribe(
      channelName: "my-channel",
      onEvent: onEvent,
    );
  }

  void unsubscribePusher() async {
    await pusher.unsubscribe(channelName: "my-channel");
  }

  void onEvent(PusherEvent event) {
    print("onEvent: $event");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }
}