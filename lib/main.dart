import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/screens/product/product_screen.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/shared/bloc_observer.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/firebase_helper/notification_helper.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/network/remote/dio.dart';
import 'package:soldout/shared/uuid/uuid.dart';
import 'package:soldout/splash_screen.dart';
import 'layout/vendor_layout/cubit/vendor_cubit.dart';
import 'modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';
import 'modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_cubit.dart';
//🌎
void main() async{
//🌎


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  if(defaultTargetPlatform == TargetPlatform.android)
  {
    deviceType = 0;
  }

  if(defaultTargetPlatform == TargetPlatform.iOS)
  {
    deviceType = 1;
  }

  DioHelper.init1();

  fcmToken = await  FirebaseMessaging.instance.getToken();
  print(fcmToken);

  NotificationHelper();

  await EasyLocalization.ensureInitialized();

  await CacheHelper.init();

  onBoarding = CacheHelper.getData(key: 'onBoarding');

  myLocale = CacheHelper.getData(key: 'locale');

  token = CacheHelper.getData(key: 'token');
  print(token);
  vToken = CacheHelper.getData(key: 'vToken');
  print(vToken);

  isFirst = CacheHelper.getData(key: 'isFirst');

  showAuctionHint = CacheHelper.getData(key: 'showAuctionHint');

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
        BlocProvider(create: (context)=> BuyerCubit()..checkInterNet()
          ..dynamicLink()..getHomeData(context),
        ),
        BlocProvider(create: (context)=> VendorCubit()
          ..checkInterNet()..dynamicLink(context)
          ..getStatistic(context: context),
        ),
        BlocProvider(create: (context)=> AuctionCubit()..checkInterNet()
          ..initPusher()
        ),
        BlocProvider(create: (context)=> AuthCubit()..checkInterNet(),
        ),
        BlocProvider(create: (context)=> AddressCubit()..checkInterNet()
          ..getAddress(),
        ),
        BlocProvider(create: (context)=> CartCubit()..checkInterNet()
          ..getCart(),
        ),
        BlocProvider(create: (context)=> SettingsCubit()..getSettingsData()
          ..checkInterNet(),
        ),
        BlocProvider(create: (context)=> VAuthCubit()..checkInterNet()),
        BlocProvider(create: (context)=> VSettingCubit()..getProfile()
          ..checkInterNet()
        ),
      ],
      child: MaterialApp(
        title: 'Sold Out',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: '/',
        routes: {
          '/product':(context)=> ProductScreen(
            product: BuyerCubit.get(context).productDetailsModel,
          )
        },
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Cairo',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


