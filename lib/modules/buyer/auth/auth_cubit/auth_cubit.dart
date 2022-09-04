import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import 'package:soldout/shared/network/remote/end_point.dart';
import 'package:soldout/splash_screen.dart';
import '../../../../models/buyer_model/get_profile_model.dart';
import '../../../../shared/components/components.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {


  AuthCubit() : super(InitState());

  static AuthCubit get (context) => BlocProvider.of(context);

  GetProfileModel? getProfileModel;


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
      emit(GetCodeErrorState(e.toString()));
    });
  }

  void signOut(context)async{
    token = null;
    CacheHelper.removeData('token');
    navigateAndFinish(context, SplashScreen());
    emit(SignOutLoadingState());
    await DioHelper.getData(
        url: logout,
        token: 'Bearer $token'
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
      showToast(msg: e.toString(),toastState: false);
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
      showToast(msg: e.toString(),toastState: false);
      emit(GetProfileErrorState());
      });
  }

}
