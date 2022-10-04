import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
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

  static AuthCubit get(context) => BlocProvider.of(context);

  GetProfileModel? getProfileModel;
  TextEditingController phoneController = TextEditingController();
  bool timerFinished = false;
  Timer? timer;

  checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }

  Future logIn(context, bool isNoty) async {
    emit(LoginLoadingState());
    bool model = CartCubit.get(context).getCartModel != null;
    bool?haveCart=model?CartCubit.get(context).getCartModel!.data!.isNotEmpty:null;
    return await DioHelper.postData(url: login, data: {
      'phone': phoneController.text.trim(),
      'code': code,
      'device_type': deviceType,
      'firebase_token': fcmToken,
      'uuid': haveCart != null ? haveCart ? uuid.toString() : null : null,
    }).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        showToast(msg: tr('verification_success'));
        CacheHelper.saveData(key: 'token', value: token);
        timer!.cancel();
        timerFinished = true;
        if(BuyerCubit.get(context).homeModel!=null){
          BuyerCubit.get(context).getHomeData(context);
          CartCubit.get(context).getCart();
        }
        navigateAndFinish(context, BuyerLayout());
        emit(LoginSuccessState());
      } else {
        showToast(msg: tr('wrong'), toastState: true);
        emit(LoginWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(LoginErrorState());
    });
  }

  void sign({String? name, required String phone}) async {
    emit(SignLoadingState());
    await DioHelper.postData(
      url: log,
      data: {
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      if (value.statusCode == 200 && value.data['status']) {
        token = value.data['data']['access_token'];
        code = value.data['data']['code'];
        emit(SignSuccessState());
      } else {
        showToast(msg: tr('wrong'), toastState: true);
        emit(SignWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(SignErrorState());
    });
  }

  void getCode() async {
    await DioHelper.getData(url: getPassCode, token: 'Bearer $token')
        .then((value) {
      code = value.data['data']['code'];
      showToast(msg: '${tr('code_is')} $code');
      emit(GetCodeSuccessState());
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(GetCodeErrorState());
    });
  }

  void signOut(context, int delete) async {
    CartCubit.get(context).getCartModel = null;
    token = null;
    CacheHelper.removeData('token');
    navigateAndFinish(context, const SplashScreen());
    await DioHelper.postData(
        url: logout,
        token: 'Bearer $token',
        data: {'delete_account': delete}
        );
    emit(SignOutLoadingState());
  }

  void updateProfile(String name) async {
    emit(UpdateProfileLoadingState());
    await DioHelper.postData(url: editProfile, token: 'Bearer $token', data: {
      'name': name,
      'device_type': deviceType,
      'firebase_token': fcmToken,
    }).then((value) {
      if (value.data['status']) {
        CacheHelper.removeData('token');
        token = value.data['data']['access_token'];
        CacheHelper.saveData(key: 'token', value: token);
        showToast(msg: tr('data_updated'));
        emit(UpdateProfileSuccessState());
      } else {
        showToast(msg: tr('wrong'), toastState: true);
        emit(UpdateProfileWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(UpdateProfileErrorState());
    });
  }

  void getProfile() async {
    emit(GetProfileLoadingState());
    await DioHelper.getData(
      url: getUserProfile,
      token: 'Bearer $token',
    ).then((value) {
      if (value.statusCode == 200) {
        getProfileModel = GetProfileModel.fromJson(value.data);
        emit(GetProfileSuccessState());
      } else {
        showToast(msg: tr('wrong'), toastState: true);
        emit(GetProfileWrongState());
      }
    }).catchError((e) {
      showToast(msg: tr('wrong'), toastState: false);
      emit(GetProfileErrorState());
    });
  }
}
