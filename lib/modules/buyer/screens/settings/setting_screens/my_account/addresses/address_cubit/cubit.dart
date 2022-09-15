import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/state.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/remote/dio.dart';

import '../../../../../../../../models/buyer_model/get_address_model.dart';
import '../../../../../../../../shared/network/remote/end_point.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(InitState());

  static AddressCubit get(context) => BlocProvider.of(context);

  GetAddressModel? getAddressModel;

  checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      print(isConnect);
      emit(JustEmitState());
    });
  }

  void addAddress({
    required String title,
    required String address,
    required int cityId,
    required int neighborhoodId,
  }) async {
    emit(AddAddressLoadingState());
    await DioHelper.postData(
        url: addAddresses,
        token: 'Bearer $token',
        lang: myLocale,
        data: {
      'title': title,
      'address': address,
      'city_id': cityId,
      'neighborhood_id': neighborhoodId,
    }).then((value) {
      if (value.data['status']&&value.statusCode == 200)  {
        showToast(msg: 'Address Added Successfully');
        getAddress();
      } else {
        showToast(msg: tr('wrong'));
        emit(AddAddressWrongState());
      }
    }).catchError((e) {
      showToast(msg: e.toString());
      emit(AddAddressErrorState());
    });
  }
  void editAddress({
    required String title,
    required String address,
    required int cityId,
    required int neighborhoodId,
    required int addressId,
  }) async {
    emit(EditAddressLoadingState());
    await DioHelper.postData(
        url: updateAddresses,
        token: 'Bearer $token',
        lang: myLocale,
        data: {
      'address_id': addressId,
      'title': title,
      'address': address,
      'neighborhood_id': neighborhoodId,
      'city_id': cityId,
    }).then((value) {
      if (value.data['status']&&value.statusCode == 200) {
        showToast(msg: 'Address Edited Successfully');
        getAddress();
      } else {
        showToast(msg: tr('wrong'));
        emit(EditAddressWrongState());
      }
    }).catchError((e) {
      showToast(msg: e.toString());
      emit(EditAddressErrorState());
    });
  }

  void getAddress() async {
    emit(GetAddressLoadingState());
    await DioHelper.getData(
        url: getAllAddresses,
        token: 'Bearer $token',
        lang: myLocale,
    ).then((value) {
      if (value.data['status']&&value.statusCode == 200) {
        getAddressModel = GetAddressModel.fromJson(value.data);
        emit(GetAddressSuccessState());
      } else {
        showToast(msg: tr('wrong'),toastState: true);
        emit(GetAddressWrongState());
      }
    }).catchError((e) {
      print(e);
      showToast(msg: e.toString(),toastState: false);
      emit(GetAddressErrorState());
    });
  }

  void removeAddress(int addressId) async {
    emit(RemoveAddressLoadingState());
    await DioHelper.postData(
      url: deleteAddresses,
      token: 'Bearer $token',
      lang: myLocale,
      data: {
        'address_id':addressId,
      }
    ).then((value) {
      if (value.data['status']&&value.statusCode == 200) {
        getAddress();
      } else {
        showToast(msg: tr('wrong'),toastState: true);
        emit(RemoveAddressWrongState());
      }
    }).catchError((e) {
      print(e);
      showToast(msg: e.toString(),toastState: false);
      emit(RemoveAddressErrorState());
    });
  }
}
