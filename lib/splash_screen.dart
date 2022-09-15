import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';
import 'layout/buyer_layout/cubit/buyer_cubit.dart';
import 'layout/vendor_layout/cubit/vendor_cubit.dart';
import 'layout/vendor_layout/vendor_layout_screen.dart';
import 'modules/buyer/widgets/scroll_hint/scroll_hint.dart';
import 'modules/intro/onBoarding/onBoarding_screen.dart';
import 'modules/intro/select_type/select_type.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    Timer(const Duration(seconds: 4), () async
    {
      if(isConnect!= null)checkNet(context);
      // final status = await NewVersion().getVersionStatus();
      // print(status);
      if (onBoarding != null) {
        if (token != null) {
          BuyerCubit.get(context).currentIndex=0;
          BuyerCubit.get(context).getHomeData(context);
          navigateAndFinish(context, BuyerLayout());
        } else if (vToken != null) {
          VendorCubit.get(context).currentIndex = 0;
          VendorCubit.get(context).getStatistic(context:context);
          navigateAndFinish(context, VendorLayout());
        } else {
          navigateAndFinish(context, SelectType());
        }
      } else {
        navigateAndFinish(context, OnBoardingScreen());
      }


    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: defaultColorTwo,
      body: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          if(!mounted){
            if(isConnect!=null)checkNet(context);
          }
        },
        builder: (context, state) {
          return Container(
            alignment: AlignmentDirectional.center,
            child: Image.asset(
              BuyerImages.splashLogo, width: size!.width * .7,),
          );
        },
      ),
    );
  }
}
