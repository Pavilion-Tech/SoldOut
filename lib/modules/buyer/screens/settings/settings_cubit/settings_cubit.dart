import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../../models/buyer_model/get_points.dart';
import '../../../../../models/buyer_model/order_model.dart';
import '../../../../../models/buyer_model/settings_model.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/network/remote/dio.dart';
import '../../../../../shared/network/remote/end_point.dart';
import '../../../widgets/paymen/payment.dart';

class SettingsCubit extends Cubit<SettingsStates>{
  SettingsCubit(): super(InitState());

  static SettingsCubit get(context)=> BlocProvider.of(context);

  OrderModel? orderModel;

  OrderData? searchOrderModel;

  SettingsModel? settingsModel;

  GetPointsModel? getPointsModel;

  TextEditingController searchController = TextEditingController();


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

  void getOrder()async
  {
    emit(GetOrderLoadingState());
    await DioHelper.getData(
        url: order,
        lang: 'en',
        token: 'Bearer $token',
    ).then((value) {
      if(value.statusCode == 200 && value.data['status']){
        orderModel = OrderModel.fromJson(value.data);
        emit(GetOrderSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(GetOrderWrongState());
      }
    }).catchError((e){
      emit(GetOrderErrorState());
      showToast(msg: tr('wrong'),toastState: false);
    });
  }

  void contactUs({
  required String name,
  required String email,
  required String phone,
  required String subject,
  required String message,
})async
  {
    String currentToken = token != null ? token! : vToken!;
    emit(ContactUsLoadingState());
    await DioHelper.postData(
        url: sendContactUs,
        lang: myLocale,
        token: 'Bearer $currentToken',
        data: {
          'name':name,
          'email':email,
          'phone':phone,
          'subject':subject,
          'message':message,
      }
    ).then((value) {
      if(value.statusCode == 200 && value.data['status']){
        showToast(msg: tr('message_successfully'));
        emit(ContactUsSuccessState());
      }else if(value.data!=null&&!value.data['status'])
      {
        showToast(msg:value.data['errors'].toString(),toastState: true);
        emit(ContactUsWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(ContactUsWrongState());
      }
    }).catchError((e){
      emit(ContactUsErrorState());
      showToast(msg: tr('wrong'),toastState: false);
    });
  }

  void searchOrder(int id)
  {
    for(var order in orderModel!.data!)
    {
      if(order.id == id )
      {
        searchOrderModel = order;
        emit(SearchState());
      }
    }
  }

  void nullSearch()
  {
    searchOrderModel = null;
    emit(SearchState());
  }

  void rateProduct({
    required int id,
    required double rate,
    required String review,
    required BuildContext context,
  })async
  {
    emit(RateLoadingState());
    await DioHelper.postData(
        url: rateProducts,
        lang: myLocale,
        token: 'Bearer $token',
        data: {
          'rate':rate.toInt(),
          'review':review,
          'order_product_id':id,
        }
    ).then((value) {
      if(value.statusCode == 200 && value.data['status']){
        showToast(msg: 'Review Sent Successful');
        Navigator.pop(context);
        emit(RateSuccessState());
      }else if(value.data!=null&&!value.data['status']){
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(RateWrongState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(RateWrongState());
      }
    }).catchError((e){
      emit(RateErrorState());
      showToast(msg: tr('wrong'),toastState: false);
    });
  }

  void getAllPoints()async
  {
    emit(GetPointsLoadingState());
    await DioHelper.getData(
      url: points,
      lang: myLocale,
      token: 'Bearer $token',
    ).then((value) {
      if(value.statusCode == 200 && value.data['status']){
        getPointsModel = GetPointsModel.fromJson(value.data);
        emit(GetPointsSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(GetPointsWrongState());
      }
    }).catchError((e){
      emit(GetPointsErrorState());
      showToast(msg: tr('wrong'),toastState: false);
    });
  }

  void buyPoints({
    required int id,
    required BuildContext context,
})async
  {
    emit(GetPointsLoadingState());
    await DioHelper.postData(
      url: points,
      lang: myLocale,
      token: 'Bearer $token',
      data: {
        'point_id':id
      }
    ).then((value) {
     if(value.statusCode == 200){
      String link = value.data['data']['payment_link'];
      navigateTo(context, Payment(url: link,));
       getAllPoints();
      }
      else{
       showToast(msg: tr('wrong'),toastState: true);
       emit(GetPointsWrongState());
     }
    }).catchError((e){
      emit(GetPointsErrorState());
      showToast(msg: tr('wrong'),toastState: false);
    });
  }


  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(CheckNetState());
    });
  }

}