import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/layout/vendor_layout/vendor_layout_screen.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import '../../../../layout/vendor_layout/cubit/vendor_cubit.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/remote/end_point.dart';
import '../../../../splash_screen.dart';
import '../../widgets/auth/forget_password/reset_dialog.dart';
import '../../widgets/auth/forget_password/step_tree.dart';
import '../../widgets/auth/vendor_signin_widget.dart';
import '../vendor_sign_in_screen.dart';
import '../vendor_verfication.dart';

class VAuthCubit extends Cubit<VAuthStates>
{
  VAuthCubit() : super(InitState());

  static VAuthCubit get(context)=>BlocProvider.of(context);

  bool password = true;
  bool resetPassword = true;
  bool resetCPassword = true;
  bool passwordLogin = true;
  bool confirmPassword = true;
  bool timerFinished = false;
  Timer? timer;
  TextEditingController attachRegister = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }


  void changeVisibility()
  {
    password = !password;
    emit(ChangePasswordShowState());
  }
  void changeConfirmVisibility()
  {
    confirmPassword = !confirmPassword;
    emit(ChangePasswordShowState());
  }
  void changeLoginVisibility()
  {
    passwordLogin = !passwordLogin;
    emit(ChangePasswordShowState());
  }

  void changeResetVisibility()
  {
    resetPassword = !resetPassword;
    emit(ChangePasswordShowState());
  }
  void changeResetCVisibility()
  {
    resetCPassword = !resetCPassword;
    emit(ChangePasswordShowState());
  }

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;

  void selectFile() async {
    final XFile? selectedImages = await
    imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      image = selectedImages;
      attachRegister.text = 'Commercial Register';
      emit(FilePickedState());
    }
  }


  void register (
  {
  required String name,
  required String email,
  required String phone,
  required String password,
  required BuildContext context,
}) async
  {
    File file = await FlutterNativeImage.compressImage(image!.path,quality:1);
    showToast(msg: tr('wait'));
    emit(RegisterLoadingState());
    FormData formData = FormData.fromMap({
      'name':name,
      'email':email,
      'phone':phone,
      'password':password,
      'commercial_register': await MultipartFile.fromFile(file.path, filename:file.path.split('/').last),
    });
    await DioHelper.postData2(
        url: vRegister,
        formData: formData
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        //showToast(msg: value.data['msg']);
        vToken = value.data['data']['access_token'];
        code = value.data['data']['code'];
        navigateTo(context,VVerificationScreen(isStepTwo: false,));
        emit(RegisterSuccessState());
      }else if(value.data!= null && !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(RegisterWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(RegisterWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(RegisterErrorState());

    });
  }

  void activeVAccount ({required BuildContext context,}) async
  {
    emit(ActiveAccountLoadingState());
    await DioHelper.postData(
        url: activeAccount,
        token: 'Bearer $vToken',
        data: {
          'code':code,
          'device_type':deviceType,
          'firebase_token': cacheFcm??fcmToken??'fcmToken',
        }
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        timer!.cancel();
        timerFinished = true;
        showToast(msg: value.data['msg']);
        navigateAndFinish(context,VSignInScreen());
        emit(ActiveAccountSuccessState());
      }else if(value.data!= null&& !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(ActiveAccountWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(ActiveAccountWrongState());
      }

    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(ActiveAccountErrorState());

    });
  }

  void resendVActivationCode () async
  {
    emit(ActiveAccountLoadingState());
    await DioHelper.postData(
        url: resendActivationCode,
        token: 'Bearer $vToken'
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        code = value.data['data']['code'];
        showToast(msg: '${tr('code_is')} $code');
        emit(ActiveAccountSuccessState());
      }else if(value.data!= null && !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(ActiveAccountWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(ActiveAccountWrongState());
      }

    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(ActiveAccountErrorState());

    });
  }

  void login ({
  required String phone,
  required String password,
  required BuildContext context,
})  async
  {
    VendorCubit.get(context).currentIndex = 0;
    emit(LoginLoadingState());
    await DioHelper.postData(
        url: vLogin,
        data: {
          'phone':phone,
          'password':password,
          'device_type':deviceType,
          'firebase_token': cacheFcm??fcmToken??'fcmToken',
        }
        ).then((value) {
          print(value.data);
      if(value.statusCode == 200 &&value.data['status']){
        bool? verified = value.data['data']['verified'];
        vToken = value.data['data']['access_token'];
        if(verified!=null){
          code = value.data['data']['code'];
          navigateTo(context,VVerificationScreen(isStepTwo: false,));
        }else{
          CacheHelper.saveData(key: 'vToken', value: vToken);
          navigateTo(context, VendorLayout());
        }
        emit(LoginSuccessState());
      }else if(value.data!= null && !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(LoginWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(LoginWrongState());
      }

    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(LoginErrorState());

    });
  }

  void loginOut ({
    required BuildContext context,
    required int deleteAccount,
  }) async
  {
    emit(LogOutLoadingState());
    await DioHelper.postData(
        url: vLogout,
        token: 'Bearer $vToken',
        data: {'delete_account':deleteAccount}
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        vToken = null;
        CacheHelper.removeData('vToken');
        navigateAndFinish(context,const SplashScreen());
        emit(LogOutSuccessState());
      }else if(value.data!= null && !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(LogOutWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(LogOutWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(LogOutErrorState());
    });
  }


  ///ResetPassword

  void requestReset()async
  {
    emit(RequestResetLoadingState());
    await DioHelper.postData(
      url: vRequestReset,
      data: {
        'phone':phoneC.text.trim()
      }
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        code = value.data['data']['reset_code'];
        showToast(msg: '${tr('code_is')} $code');
        emit(RequestResetSuccessState());
      }else if(value.data!= null && !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(RequestResetWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(RequestResetWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(RequestResetErrorState());
    });
  }

  void createReset({required BuildContext context})async
  {
    emit(CreateResetLoadingState());
    await DioHelper.postData(
        url: vCreateReset,
        data: {
          'phone':phoneC.text.trim(),
          'reset_code':code,
        }
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        vToken = value.data['data']['access_token'];
        timer!.cancel();
        timerFinished = true;
        navigateTo(context, ResetPassword());
        emit(CreateResetSuccessState());
      }else if(value.data!= null && !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(CreateResetWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(CreateResetWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(CreateResetErrorState());
    });
  }

  void resetNewPassword({required BuildContext context,required String password})async
  {
    emit(ResetLoadingState());
    await DioHelper.postData(
        url: vResetPassword,
        token: 'Bearer $vToken',
        data: {
          'new_password':password,
        }
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        showDialog(context: context, builder: (context){
          return const ResetDialog();
        });
        emit(ResetSuccessState());
      }else if(value.data!= null && !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(ResetWrongState());
      }else{
         showToast(msg: tr('wrong'),toastState: true);
        emit(ResetWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(ResetErrorState());
    });
  }
}