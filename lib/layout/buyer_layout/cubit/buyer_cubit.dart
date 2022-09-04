import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_screen.dart';
import 'package:soldout/modules/buyer/screens/notification/notification_screen.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screen.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import 'package:soldout/shared/network/remote/end_point.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/buyer_model/get_fav_model.dart';
import '../../../models/buyer_model/home_model/home_model.dart';
import '../../../models/buyer_model/search_model.dart';
import '../../../models/buyer_model/settings_model.dart';
import '../../../modules/buyer/screens/home/home_screen.dart';
import '../../../shared/components/constants.dart';
import 'buyer_states.dart';

class BuyerCubit extends Cubit<BuyerStates>{
  BuyerCubit(): super(InitState());

  static BuyerCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;

  bool showAuctionHint= true;

  SettingsModel? settingsModel;

  HomeModel? homeModel;

  Map<int,bool> favorites = {};

  GetFavModel? getFavModel;

  SearchModel? searchModel;



  List<Widget> screens = [
    HomeScreen(),
    const NotificationScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];


  void changeAuctionHint(){
    showAuctionHint = !showAuctionHint;
    emit(ChangeAuctionHintState());
  }

  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }
  
  void getSettingsData()async
  {
    await DioHelper.getData(
        url: settings,
        lang: myLocale
    ).then((value) {
      settingsModel = SettingsModel.fromJson(value.data);
      emit(GetSettingsSuccess());
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetSettingsError());
    });
  }


  void getHomeData() async
  {
    emit(GetHomeDataLoadingState());
    await DioHelper.getData(
        url: userHomeData,
        lang: myLocale
    ).then((value){
      if(value.statusCode == 200&&value.data['status']){
        homeModel = HomeModel.fromJson(value.data);
        for(var newProduct in homeModel!.data!.newProducts! ){
          favorites.addAll({
            newProduct.id! : newProduct.isFavourite!
          });
        }
        for (var category in homeModel!.data!.categories!) {
          for(var product in category.products!){
            favorites.addAll({
              product.id! : product.isFavourite!
            });
          }
        }
        emit(GetHomeDataSuccessState());
        print(favorites);
      }else{
        showToast(msg: tr('wrong'),toastState: false);
        emit(GetHomeDataWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetHomeDataErrorState());
    });
  }


  void updateFav(int id)async
  {
    emit(ChangeFavLoadingState());
    favorites[id] = !favorites[id]!;
    await DioHelper.postData(
        url: fav,
        token: 'Bearer $token',
        lang: myLocale,
        data: {
        'product_id':id,
        }
        ).then((value) {
          if(value.statusCode == 200 && value.data['status'])
          {
            getFav();
            emit(ChangeFavSuccessState());
          }else{
            favorites[id] = !favorites[id]!;
            showToast(msg: tr('wrong'));
            emit(ChangeFavWrongState());
          }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      favorites[id] = !favorites[id]!;
      emit(ChangeFavErrorState());
    });
  }

  void getFav()async
  {
    emit(GetFavLoadingState());
    await DioHelper.getData(
        url: fav,
        token: 'Bearer $token',
        lang: myLocale,
    ).then((value) {
      if(value.statusCode == 200 && value.data['status'])
      {
        getFavModel = GetFavModel.fromJson(value.data);
        for(var product in getFavModel!.data!.products!){
          favorites.addAll({
            product.id! : product.isFavourite!,
          });
        }
        emit(GetFavSuccessState());
      }else{
        print(value.data);
        showToast(msg: tr('wrong'));
        emit(GetFavWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(GetFavErrorState());
    });
  }

  void search({
  String? text,
    int sort = 1,
})async
  {
    emit(SearchLoadingState());
    await DioHelper.getData(
      url:'/users/home/getSearchProducts?sort_type=$sort&search_text=$text&page=1',
      token: 'Bearer $token',
      lang: myLocale,
    ).then((value) {
      if(value.statusCode == 200 && value.data['status'])
      {
        print(value.data);
        searchModel = SearchModel.fromJson(value.data);
        for(var product in searchModel!.data!.products!){
          favorites.addAll({
            product.id! : product.isFavourite!,
          });
        }
        emit(SearchSuccessState());
      }else{
        print(value.data);
        showToast(msg: value.data['errors'],toastState: true);
        emit(SearchWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'),toastState: false);
      emit(SearchErrorState());
    });
  }

  void updateLang(String currentLang)async
  {
    await DioHelper.postData(
      url: changeLang,
      lang: myLocale,
      token: 'Bearer $token',
      data: {
        'current_lang':currentLang
      }
    );
  }



  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}