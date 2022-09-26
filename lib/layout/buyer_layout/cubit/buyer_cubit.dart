import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_screen.dart';
import 'package:soldout/modules/buyer/screens/notification/notification_screen.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screen.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import 'package:soldout/shared/network/remote/end_point.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../main.dart';
import '../../../models/buyer_model/get_fav_model.dart';
import '../../../models/buyer_model/home_model/home_model.dart';
import '../../../models/buyer_model/list_products_model.dart';
import '../../../models/buyer_model/product_model/product_model.dart';
import '../../../models/notification_model.dart';
import '../../../modules/buyer/screens/auction/auction_list_screen.dart';
import '../../../modules/buyer/screens/home/home_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/firebase_helper/dynamic_links.dart';
import 'buyer_states.dart';

class BuyerCubit extends Cubit<BuyerStates> {
  BuyerCubit() : super(InitState());

  static BuyerCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  GetFavModel? getFavModel;

  ListProductModel? searchModel;

  ListProductModel? categoryModel;

  ListProductModel? storeModel;

  ProductModel? productDetailsModel;

  NotificationModel? notificationModel;

  ScrollController scrollControllerForSearch = ScrollController();

  ScrollController scrollControllerForCategory = ScrollController();

  ScrollController scrollControllerForStore = ScrollController();

  int currentSearchPage = 1;

  int currentCategoryPage = 1;

  int currentStorePage = 1;

  List<Widget> screens = [
    HomeScreen(),
    const NotificationScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }

  void dynamicLink() {
    DynamicLinksClient.initDynamicLinks((String? value) {
      if (value != null) {
        getProduct(id: int.parse(value));
      }
    });
  }

  void changeAuctionHint() {
    showAuctionHint = true;
    emit(ChangeAuctionHintState());
    CacheHelper.saveData(key: 'showAuctionHint', value: true);
  }

  void emitState() {
    emit(JustEmitState());
  }

  void changeIndex(int index, {BuildContext? context}) {
    currentIndex = index;
    if (currentIndex == 0) getHomeData(context);
    emit(ChangeIndexState());
  }

  void takeFav(List<ProductModel> product) {
    for (var newProduct in product) {
      favorites.addAll({newProduct.id!: newProduct.isFavourite!});
    }
  }

  void getHomeData(context,{bool isAuction = false}) async {
    if (!isConnect!) checkNet(context);
    emit(GetHomeDataLoadingState());
    await DioHelper.getData(url: userHomeData, lang: myLocale).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        homeModel = HomeModel.fromJson(value.data);
        takeFav(homeModel!.data!.newProducts!);
        for (var category in homeModel!.data!.categories!) {
          takeFav(category.products!);
        }
        if(isAuction)
        {
          navigateTo(context,AuctionsListScreen(
            newAuctions:homeModel!.data!.newAuctions!,
          ));
        }
        emit(GetHomeDataSuccessState());
      } else {
        showToast(msg: tr('wrong'), toastState: false);
        emit(GetHomeDataWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(GetHomeDataErrorState());
    });
  }

  void updateFav(int id) async {
    emit(ChangeFavLoadingState());
    favorites[id] = !favorites[id]!;
    await DioHelper.postData(
        url: fav,
        token: 'Bearer $token',
        lang: myLocale,
        data: {
          'product_id': id,
        }).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        getFav();
        } else {
        favorites[id] = !favorites[id]!;
        showToast(msg: tr('wrong'));
        emit(ChangeFavWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'));
      favorites[id] = !favorites[id]!;
      emit(ChangeFavErrorState());
    });
  }

  void getFav() async {
    emit(GetFavLoadingState());
    await DioHelper.getData(
      url: fav,
      token: 'Bearer $token',
      lang: myLocale,
    ).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        getFavModel = GetFavModel.fromJson(value.data);
        takeFav(getFavModel!.data!.products!);
        emit(GetFavSuccessState());
      } else {
        showToast(msg: tr('wrong'));
        emit(GetFavWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'));
      emit(GetFavErrorState());
    });
  }

  void getListProductsForSearch({
    String text = '',
    int sort = 1,
    int page = 1,
    bool isPage = false,
  }) async {
    String url =
        '/users/home/getSearchProducts?sort_type=$sort&search_text=$text&page=$page';
    emit(SearchLoadingState());
    await DioHelper.getData(
      url: url,
      token: 'Bearer $token',
      lang: myLocale,
    ).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        if (isPage) {
          searchModel!.data!.lastPage = value.data['data']['last_page'];
          searchModel!.data!.currentPage = value.data['data']['current_page'];
          for (Map<String, dynamic> product in value.data['data']['products']) {
            searchModel!.data!.products!.add(ProductModel.fromJson(product));
            emit(SearchSuccessState());
          }
          takeFav(searchModel!.data!.products!);
          emit(SearchSuccessState());
        } else {
          searchModel = ListProductModel.fromJson(value.data);
          takeFav(searchModel!.data!.products!);
          emit(SearchSuccessState());
        }
      } else if (value.data != null && !value.data['status']) {
        showToast(msg: value.data['errors'].toString(), toastState: true);
        emit(SearchWrongState());
      }
    }).catchError((e) {
      print(e.toString());
      showToast(msg: tr('wrong'), toastState: false);
      emit(SearchErrorState());
    });
  }

  void getListProductsForCategory({
    String? text,
    int sort = 1,
    int page = 1,
    required int id,
    bool isPage = false,
  }) async {
    emit(SearchLoadingState());
    await DioHelper.getData(
      url:
          '/users/home/getSearchProducts?sort_type=$sort&search_text=$text&page=$page&category_id=$id',
      token: 'Bearer $token',
      lang: myLocale,
    ).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        if (isPage) {
          categoryModel!.data!.lastPage = value.data['data']['last_page'];
          categoryModel!.data!.currentPage = value.data['data']['current_page'];
          for (Map<String, dynamic> product in value.data['data']['products']) {
            categoryModel!.data!.products!.add(ProductModel.fromJson(product));
            emit(SearchSuccessState());
          }
          takeFav(categoryModel!.data!.products!);
          emit(SearchSuccessState());
        } else {
          categoryModel = ListProductModel.fromJson(value.data);
          takeFav(categoryModel!.data!.products!);
          emit(SearchSuccessState());
        }
      } else if (value.data != null && !value.data['status']) {
        showToast(msg: value.data['errors'].toString(), toastState: true);
        emit(SearchWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(SearchErrorState());
    });
  }

  void getListProductsForStore({
    String? text,
    int sort = 0,
    int page = 1,
    required int id,
    bool isPage = false,
  }) async {
    emit(SearchLoadingState());
    await DioHelper.getData(
      url:
          '/users/home/getSearchProducts?sort_type=$sort&search_text=$text&page=$page&store_id=$id',
      token: 'Bearer $token',
      lang: myLocale,
    ).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        if (isPage) {
          storeModel!.data!.lastPage = value.data['data']['last_page'];
          storeModel!.data!.currentPage = value.data['data']['current_page'];
          for (Map<String, dynamic> product in value.data['data']['products']) {
            storeModel!.data!.products!.add(ProductModel.fromJson(product));
            emit(SearchSuccessState());
          }
          takeFav(storeModel!.data!.products!);
          emit(SearchSuccessState());
        } else {
          storeModel = ListProductModel.fromJson(value.data);
          takeFav(storeModel!.data!.products!);
          emit(SearchSuccessState());
        }
      } else {
        showToast(msg: tr('wrong'), toastState: true);
        emit(SearchWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(SearchErrorState());
    });
  }

  void getProduct({required int id}) async {
    emit(GetProductLoadingState());
    await DioHelper.getData(url: '/users/home/getProductDetails?product_id=$id')
        .then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        productDetailsModel = ProductModel.fromJson(value.data['data']);
        favorites.addAll(
            {productDetailsModel!.id!: productDetailsModel!.isFavourite!});
        navigatorKey.currentState!.pushNamed(
          '/product',
        );
        emit(GetProductSuccessState());
      } else {
        showToast(msg: tr('wrong'), toastState: true);
        emit(GetProductWrongState());
      }
    }).catchError((e) {
      emit(GetProductErrorState());
    });
  }

  TextEditingController searchController = TextEditingController();

  void getMoreForSearch() {
    scrollControllerForSearch.addListener(() {
      print(scrollControllerForSearch.offset);
      if (state is! SearchLoadingState) {
        if (scrollControllerForSearch.offset ==
            scrollControllerForSearch.position.maxScrollExtent) {
          if (searchModel!.data!.currentPage != searchModel!.data!.lastPage) {
            currentSearchPage++;
            getListProductsForSearch(
                text: searchController.text,
                page: currentSearchPage,
                isPage: true);
          }
        }
      }
    });
  }

  TextEditingController categoryController = TextEditingController();

  void getMoreForCategory(int id) {
    scrollControllerForCategory.addListener(() {
      if (state is! SearchLoadingState) {
        if (scrollControllerForCategory.offset ==
            scrollControllerForCategory.position.maxScrollExtent) {
          if (categoryModel!.data!.currentPage !=
              categoryModel!.data!.lastPage) {
            currentCategoryPage++;
            getListProductsForCategory(
              text: categoryController.text,
              page: currentCategoryPage,
              isPage: true,
              id: id,
            );
          }
        }
      }
    });
  }

  TextEditingController storeController = TextEditingController();

  void getMoreForStore(int id) {
    scrollControllerForStore.addListener(() {
      if (state is! SearchLoadingState) {
        if (scrollControllerForStore.offset ==
            scrollControllerForStore.position.maxScrollExtent) {
          if (storeModel!.data!.currentPage != storeModel!.data!.lastPage) {
            currentStorePage++;
            getListProductsForStore(
              text: storeController.text,
              page: currentStorePage,
              isPage: true,
              id: id,
            );
          }
        }
      }
    });
  }

  void getNotifications()async
  {
    emit(GetNotificationLoadingState());
    await DioHelper.getData(
      url: fetchNotification,
      token: 'Bearer $token',
      lang: myLocale
    ).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      emit(GetNotificationSuccessState());
    }).catchError((e){
      emit(GetNotificationErrorState());
    });
  }

  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
