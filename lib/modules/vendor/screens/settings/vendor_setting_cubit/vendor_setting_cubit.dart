import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_states.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/network/remote/end_point.dart';

class VSettingCubit extends Cubit<VSettingStates>
{
  VSettingCubit() : super(InitState());

  static VSettingCubit get(context)=>BlocProvider.of(context);

  TextEditingController attachRegister = TextEditingController();

  XFile? file;
  String? image;
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController attachC = TextEditingController();


  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }

  ImagePicker imagePicker = ImagePicker();

  void selectFile()async{
    final XFile? selectedImages = await
    imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      file = selectedImages;
      attachRegister.text = 'Commercial Register';
      emit(FilePickedState());
    }
  }

  void getProfile ()async
  {
    emit(GetProfileLoadingState());
    await DioHelper.getData(
        url: vGetProfile,
        token: 'Bearer $vToken',
        lang: myLocale,
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        nameC.text = value.data['data']['name'];
        emailC.text = value.data['data']['email'];
        phoneC.text = value.data['data']['phone'];
        image = value.data['data']['commercial_register'];
        attachC.text = 'Commercial Register';
        emit(GetProfileSuccessState());
      }else if(value.data!= null&& !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(GetProfileWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(GetProfileWrongState());
      }
    }).catchError((e){
      emit(GetProfileErrorState());
    });
  }

  void updateProfile ()async
  {
    File? _file;
    if(file!=null) _file = await FlutterNativeImage.compressImage(file!.path,quality:1);
    emit(UpdateProfileLoadingState());
    FormData formData = FormData.fromMap({
      'name':nameC.text,
      'device_type':deviceType,
      'firebase_token':fcmToken??'',
      'commercial_register':file != null
          ? await MultipartFile.fromFile(_file!.path, filename:_file.path.split('/').last)
      :await MultipartFile.fromFile(image!, filename:image!.split('/').last),
    });
    await DioHelper.postData2(
      url: vUpdateProfile,
      token: 'Bearer $vToken',
      lang: myLocale,
      formData: formData
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        showToast(msg: value.data['msg']);
        emit(UpdateProfileSuccessState());
      }else if(value.data!= null&& !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(UpdateProfileWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(UpdateProfileWrongState());
      }
    }).catchError((e){
      emit(UpdateProfileErrorState());
    });
  }

  void changePassword ({
  required String oldPassword,
  required String newPassword,
})async
  {
    emit(ChangePasswordLoadingState());
    await DioHelper.postData(
        url: vChangePassword,
        token: 'Bearer $vToken',
        lang: myLocale,
        data: {
          'old_password':oldPassword,
          'new_password':newPassword,
        }
    ).then((value) {
      if(value.statusCode == 200 &&value.data['status']){
        showToast(msg: value.data['msg']);
        emit(ChangePasswordSuccessState());
      }else if(value.data!= null&& !value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(ChangePasswordWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(ChangePasswordWrongState());
      }
    }).catchError((e){
      emit(ChangePasswordErrorState());
    });
  }

  bool oldPassword = true;
  bool newPassword = true;
  bool cNewPassword = true;

  void changeOldVisibility()
  {
    oldPassword = !oldPassword;
    emit(ChangePasswordShowState());
  }
  void changeVisibility()
  {
    newPassword = !newPassword;
    emit(ChangePasswordShowState());
  }
  void changeConfirmVisibility()
  {
    cNewPassword = !cNewPassword;
    emit(ChangePasswordShowState());
  }
  
  void changeLang(String lang)async
  {
    await DioHelper.postData(
      url: vChangeLang,
      token: 'Bearer $vToken',
      lang: lang,
      data: {
        'current_lang':lang
      }
    );
  }

}