import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/models/buyer_model/cart_model/get_cart_model.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import 'package:soldout/shared/network/remote/end_point.dart';
import 'package:soldout/splash_screen.dart';
import '../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../models/buyer_model/get_profile_model.dart';
import '../../../../shared/components/components.dart';
import '../../screens/cart/cart_cubit/cart_cubit.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {


  AuthCubit() : super(InitState());

  static AuthCubit get (context) => BlocProvider.of(context);

  GetProfileModel? getProfileModel;
  TextEditingController phoneController = TextEditingController();
  bool timerFinished = false;
  Timer? timer;

  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      print(isConnect);
      emit(JustEmitState());
    });
  }


  Future logIn(context,bool isNoty)async
  {
    print(uuid);
    print(code);
    print(phoneController.text.trim());
    emit(LoginLoadingState());
    bool model = CartCubit.get(context).getCartModel != null;
    bool? haveCart = model ? CartCubit.get(context).getCartModel!.data!.isNotEmpty : null;
    return await DioHelper.postData(
      url: login,
      data: {
        'phone':phoneController.text.trim(),
        'code':code,
        'device_type':0,
        'firebase_token':'fsdadfsa',
        'uuid':haveCart != null ? haveCart ? uuid.toString(): null:null,
      }
    ).then((value) {
      print(value.data);
      if(value.statusCode==200&&value.data['status']){
        showToast(msg: 'Verification Successfully');
        CacheHelper.saveData(key: 'token', value: token);
        timer!.cancel();
        timerFinished = true;
        BuyerCubit.get(context).getHomeData(context);
        CartCubit.get(context).getCart();
        navigateAndFinish(context, BuyerLayout());
        emit(LoginSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(LoginWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'),toastState: false);
      emit(LoginErrorState(e.toString()));
    });
  }


  void sign({String? name,required String phone}) async
  {

    emit(SignLoadingState());

    await DioHelper.postData(
      url: log,
      data: {
        'phone':phone,
        'name':name,
      },
    ).then((value)
    {
      if(value.statusCode == 200 && value.data['status']){
        token = value.data['data']['access_token'];
        code = value.data['data']['code'];
        emit(SignSuccessState());
      }else{
        showToast(msg:tr('wrong'),toastState: true);
        emit(SignWrongState());
      }
    }).catchError((e)
    {
      showToast(msg: tr('wrong'),toastState: false);
      emit(SignErrorState(e.toString()));
    });
  }

  void getCode()
  async{
    await DioHelper.getData(
      url: getPassCode,
      token: 'Bearer $token'
    ).then((value)
    {
      code = value.data['data']['code'];
      showToast(msg: 'You\'r Code $code');
      emit(GetCodeSuccessState());
    }).catchError((e)
    {
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetCodeErrorState(e.toString()));
    });
  }

  void signOut(context,int delete)async{
    token = null;
    CacheHelper.removeData('token');
    CartCubit.get(context).getCartModel=null;
    navigateAndFinish(context, SplashScreen());
    emit(SignOutLoadingState());
    await DioHelper.postData(
        url: logout,
        token: 'Bearer $token',
        data: {
          'delete_account':delete
        }
    );
  }

  void updateProfile(String name)async{
    emit(UpdateProfileLoadingState());
    await DioHelper.postData(
        url: editProfile,
        token: 'Bearer $token',
        data: {
          'name':name,
          'device_type':0,
          'firebase_token':'gsdgawe',
      }
      ).then((value) {
        print(token);
        print(value.data);
        if(value.data['status']){
          showToast(msg: 'Data Changed Successfully');
          emit(UpdateProfileSuccessState());
        }else{
          showToast(msg: tr('wrong'),toastState: true);
          emit(UpdateProfileWrongState());
        }
      }
      ).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(UpdateProfileErrorState());
      });
  }
  void getProfile()async{
    emit(GetProfileLoadingState());
    await DioHelper.getData(
        url: getUserProfile,
        token: 'Bearer $token',
      ).then((value) {
        print(value.data);

        if(value.statusCode == 200){
          getProfileModel = GetProfileModel.fromJson(value.data);
          emit(GetProfileSuccessState());
        }else{
          showToast(msg: tr('wrong'),toastState: true);
          emit(GetProfileWrongState());
        }
      }
      ).catchError((e){
        print(e.toString());
        showToast(msg: tr('wrong'),toastState: false);
      emit(GetProfileErrorState());
      });
  }

}
