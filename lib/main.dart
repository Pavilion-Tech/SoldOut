import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
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
import 'modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_cubit.dart';

void main() async{



  deviceVersion = Platform.version.indexOf('1');
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init1();

  await EasyLocalization.ensureInitialized();

  await CacheHelper.init();

  isFirst = CacheHelper.getData(key: 'isFirst');

  myLocale = CacheHelper.getData(key: 'locale');

  showAuctionHint = CacheHelper.getData(key: 'showAuctionHint');
  print(myLocale);

  token = CacheHelper.getData(key: 'token');
  print(token);
  vToken = CacheHelper.getData(key: 'vToken');
  print(vToken);

  onBoarding = CacheHelper.getData(key: 'onBoarding');

  uuid = await Uuid.getUuid();
  print(uuid);


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
        BlocProvider(create: (context)=> BuyerCubit()..getHomeData(context)..checkInterNet(),),
        BlocProvider(create: (context)=> VendorCubit()..getStatistic(context: context)..checkInterNet(),),
        BlocProvider(create: (context)=> AuthCubit()..checkInterNet(),),
        BlocProvider(create: (context)=> AddressCubit()..checkInterNet(),),
        BlocProvider(create: (context)=> CartCubit()..getCart()..checkInterNet(),),
        BlocProvider(create: (context)=> SettingsCubit()..getSettingsData()..checkInterNet(),),
        BlocProvider(create: (context)=> VAuthCubit()..checkInterNet()),
        BlocProvider(create: (context)=> VSettingCubit()..getProfile()..checkInterNet()),
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


