import 'dart:async';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';

import 'modules/intro/onBoarding/onBoarding_screen.dart';
import 'modules/intro/select_type/select_type.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{


  @override
  void initState() {
    Timer( const Duration(seconds: 4), ()
    {
     if(onBoarding != null)
     {
       if(token != null){
        navigateAndFinish(context,  BuyerLayout());
       }else{
         navigateAndFinish(context,  SelectType());
       }

     }else{
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
      body: Container(
        alignment: AlignmentDirectional.center,
        child:  Image.asset(BuyerImages.splashLogo,width: size!.width*.7,),
      ),
    );
  }
}
