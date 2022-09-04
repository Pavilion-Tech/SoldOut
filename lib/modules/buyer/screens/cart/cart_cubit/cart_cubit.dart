import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_states.dart';
import '../../../../../models/buyer_model/cart_model/get_cart_model.dart';
import '../../../../../models/buyer_model/cart_model/get_checkout_model.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/network/remote/dio.dart';
import '../../../../../shared/network/remote/end_point.dart';

class CartCubit extends Cubit<CartStates>
{

  CartCubit():super(InitState());

  static CartCubit get (context)=>BlocProvider.of(context);


  GetCartModel? getCartModel;

  GetCheckOutModel? getCheckOutModel;


  void addToCart({
  int? productId,
  int? qty,
})async
  {
    print(productId);
    emit(AddToCartLoadingState());
    await DioHelper.postData(
      url: carts,
      token:'Bearer $token',
      data: {
        'product_id':productId,
        'qty':qty,
        'uuid': uuid,
      }
    ).then((value) {
      if(value.statusCode == 200&&value.data['status']){
        showToast(msg:value.data['msg']);
        getCart();
      }else{
        print(value);
        showToast(msg: tr('wrong'),toastState: false);
        emit(AddToCartWrongState());
      }
    }).catchError((e){
      showToast(msg: e.message,toastState: false);
      emit(AddToCartErrorState());
    });
  }


  void removeToCart(int productId,)async
  {
    await DioHelper.postData(
      url: deleteCarts,
      token:'Bearer $token',
      data: {
        'product_id':productId,
      }
    ).then((value) {
      if(value.statusCode == 200&&value.data['status']){
        showToast(msg:value.data['msg']);
        getCart();
      }else{
        print(value);
        showToast(msg: tr('wrong'),toastState: false);
        emit(RemoveToCartWrongState());
      }
    }).catchError((e){
      showToast(msg: e.message,toastState: false);
      emit(RemoveToCartErrorState());
    });
  }


  void getCart()async
  {
    emit(GetCartLoadingState());
    await DioHelper.getData(
      url: carts,
      token: 'Bearer $token',
    ).then((value) {
      if(value.statusCode == 200&&value.data['status']){
        getCartModel = GetCartModel.fromJson(value.data);
        emit(GetCartSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: false);
        emit(GetCartWrongState());
      }
    }).catchError((e){
      showToast(msg: e.message,toastState: false);
      emit(GetCartErrorState());
    });
  }

  void getCheckOut()async
  {
    emit(GetCheckOutLoadingState());
    await DioHelper.getData(
      url: fetchCheckOut,
      token:  'Bearer $token',
    ).then((value) {
      if(value.statusCode == 200&&value.data['status']){
        getCheckOutModel = GetCheckOutModel.fromJson(value.data);
        emit(GetCheckOutSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: false);
        emit(GetCheckOutWrongState());
      }

    }).catchError((e){
      showToast(msg: e.message,toastState: false);
      emit(GetCheckOutErrorState());
    });
  }


}