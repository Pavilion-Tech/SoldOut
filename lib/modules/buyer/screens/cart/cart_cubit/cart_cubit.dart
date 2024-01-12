import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_states.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../models/buyer_model/cart_model/get_cart_model.dart';
import '../../../../../models/buyer_model/cart_model/get_checkout_model.dart';
import '../../../../../models/buyer_model/discount_model.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/network/remote/dio.dart';
import '../../../../../shared/network/remote/end_point.dart';
import '../../../../widgets/login_dialog.dart';
import '../../../widgets/check_out/dialog.dart';
import '../../../widgets/paymen/payment.dart';

class CartCubit extends Cubit<CartStates> {

  CartCubit() : super(InitState());

  static CartCubit get(context) => BlocProvider.of(context);

  GetCartModel? getCartModel;

  GetCheckOutModel? getCheckOutModel;

  DiscountModel? discountModel;

  Map<String , dynamic> map ={};

  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }

  void addToCart({
    int? productId,
    int? qty,
    required BuildContext context,
  }) async {
    await DioHelper.postData(
        url: carts,
        lang: myLocale,
        token: 'Bearer $token',
        data: {
      'product_id': productId,
      'qty': qty,
      'uuid': token != null ?null:uuid,
    }).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        showToast(msg: tr('item_added'));
        getCart();
      }else if(value.statusCode == 401){
        showDialog(context: context,barrierDismissible: false, builder: (context)=>LoginDialog());
      }  else {
        showToast(msg: tr('wrong'), toastState: false);
        emit(AddToCartWrongState());
      }
    }).catchError((e) {
      showToast(msg: e.message, toastState: false);
      emit(AddToCartErrorState());
    });
  }

  void removeFromCart(
    int productId,
  ) async {
    await DioHelper.postData(
        url: deleteCarts,
        token: 'Bearer $token',
        lang: myLocale,
        data: {
          'product_id': productId,
        }).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        showToast(msg: tr('Item_removed'));
        getCart();
      } else {
        showToast(msg: tr('wrong'), toastState: false);
        emit(RemoveToCartWrongState());
      }
    }).catchError((e) {
      showToast(msg: e.message, toastState: false);
      emit(RemoveToCartErrorState());
    });
  }

  void getCart() async {
    String url = token!= null?carts:'$carts?uuid=$uuid';
    emit(GetCartLoadingState());
    await DioHelper.getData(
      url: url,
      lang: myLocale,
      token: token!= null?'Bearer $token':null,
    ).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        getCartModel = GetCartModel.fromJson(value.data);
        emit(GetCartSuccessState());
      } else {
        showToast(msg: tr('wrong'), toastState: false);
        emit(GetCartWrongState());
      }
    }).catchError((e) {
      showToast(msg: e.message, toastState: false);
      emit(GetCartErrorState());
    });
  }

  void getCheckOut(BuildContext context) async {
    emit(GetCheckOutLoadingState());
    await DioHelper.getData(
      url: fetchCheckOut,
      lang: myLocale,
      token: 'Bearer $token',
    ).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        getCheckOutModel = GetCheckOutModel.fromJson(value.data);
        emit(GetCheckOutSuccessState());
      } else if(value.statusCode == 401){
        showDialog(context: context,barrierDismissible: false, builder: (context)=>LoginDialog());
      } else {
        showToast(msg: tr('wrong'),toastState: false);
        emit(GetCheckOutWrongState());
      }
    }).catchError((e) {
      showToast(msg: e.message,toastState: false);
      emit(GetCheckOutErrorState());
    });
  }

  void checkCoupon(String text) async {
    emit(CheckCouponLoadingState());
    await DioHelper.postData(
        url: coupon,
        lang: myLocale,
        token: "Bearer $token",
        data: {
          'coupon_code': text,
        }).then((value) {
          if(value.statusCode == 200&& value.data['status'])
          {
            discountModel = DiscountModel.fromJson(value.data);
            showToast(msg: value.data['msg']);
            emit(CheckCouponSuccessState());
          }
          else if(value.statusCode == 200)
          {
           showToast(msg: value.data['errors'].toString(),toastState: true);
           emit(CheckCouponWrongState());
          }
          else{
            showToast(msg: tr('wrong'),toastState: false);
            emit(CheckCouponWrongState());
          }
    }).catchError((e) {
      showToast(msg: tr('wrong'),toastState: false);
      emit(CheckCouponErrorState());
    });
  }

  void checkOut({
  required int payMethod,
    String? couponCode,
    String? address,
    int? neighborhoodId,
    int? cityId,
    int? userAddressId,
    BuildContext? context,
})async
  {
    checkOutData(
      payMethod:payMethod,
      couponCode:couponCode,
      address:address,
      neighborhoodId:neighborhoodId,
      cityId:cityId,
      userAddressId: userAddressId,
    );
    emit(CheckOutLoadingState());
    await DioHelper.postData(
        lang: myLocale,
        token: 'Bearer $token',
        url: checkout,
        data: map
    ).then((value) {
      if(value.statusCode == 200&& value.data['status'])
      {
        String link = value.data['data']['payment_link'];
        var orderId = value.data['data']['order_id'];
        if(link.isNotEmpty)
          {
           navigateTo(context, Payment(url: link,));
            getCart();
          }else{
          getCart();
          Navigator.pop(context!);
          showDialog(
              context: context,
              builder: (context)=>CheckOutDialog(orderNum: orderId,)
          );
        }
        showToast(msg: value.data['msg']);
        emit(CheckOutSuccessState());
      }
      else if(value.statusCode == 200&& !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(CheckOutWrongState());
      }
      else{
        showToast(msg: tr('wrong'),toastState: false);
        emit(CheckOutWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(CheckOutErrorState());
    });
  }

  void checkOutData({
    int? payMethod,
    String? couponCode,
    String? address,
    int? neighborhoodId,
    int? cityId,
    int? userAddressId,
}){
    if(userAddressId == null){
      if(couponCode!.isNotEmpty){
        map = {
          'payment_method':payMethod,
          'coupon_code':couponCode,
          'address':address,
          'neighborhood_id':neighborhoodId,
          'city_id':cityId,
        };
      }else{
        map = {
          'payment_method':payMethod,
          'address':address,
          'neighborhood_id':neighborhoodId,
          'city_id':cityId,
        };
      }
    }else{
      if(couponCode!.isNotEmpty){
        map = {
          'payment_method':payMethod,
          'coupon_code':couponCode,
          'user_address_id':userAddressId,
        };
      }else{
        map = {
          'payment_method':payMethod,
          'user_address_id':userAddressId,
        };
      }
    }
  }

  Future<void> openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}