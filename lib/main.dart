import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/shared/bloc_observer.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import 'package:soldout/shared/uuid/uuid.dart';
import 'package:soldout/splash_screen.dart';
import 'layout/vendor_layout/cubit/vendor_cubit.dart';
import 'modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';

void main() async{

  
  deviceVersion = Platform.version.indexOf('1');
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init1();

  await EasyLocalization.ensureInitialized();

  await CacheHelper.init();

  myLocale = CacheHelper.getData(key: 'locale');

  token = CacheHelper.getData(key: 'token');
  print(token);

  code = CacheHelper.getData(key: 'code');

  onBoarding = CacheHelper.getData(key: 'onBoarding');

  uuid = await Uuid.getUuid();


  BlocOverrides.runZoned(
        () {
          runApp(
            EasyLocalization(
              supportedLocales:  const [Locale('en'), Locale('ar')],
              useOnlyLangCode: true,
              path: 'assets/langs',
              fallbackLocale: const Locale('en'),
              startLocale: Locale(myLocale??'en'),
              child: const SoldOut(),
            ),
          );
          },
    blocObserver: MyBlocObserver(),
  );

}

class SoldOut extends StatelessWidget {
  const SoldOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> BuyerCubit()..getHomeData()..getSettingsData(),),
        BlocProvider(create: (context)=> VendorCubit(),),
        BlocProvider(create: (context)=> AuthCubit(),),
        BlocProvider(create: (context)=> AddressCubit(),),
        BlocProvider(create: (context)=> CartCubit()..getCart(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Cairo',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


