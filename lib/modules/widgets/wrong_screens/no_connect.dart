import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/splash_screen.dart';

class NoConnect extends StatelessWidget {
  const NoConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 80
          ),
          color:Colors.blue.shade100.withOpacity(.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(BuyerImages.ops),
              Column(
                children: [
                   Text(
                    tr('wrong'),
                    style:const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18
                    ),
                  ),
                   const SizedBox(height: 20,),
                   Text(
                    tr('error_loading'),
                    style:const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
              defaultButton(
                  onTap: (){
                    navigateAndFinish(context,const SplashScreen());
                  },
                  text: tr('try_again'),
                width: double.infinity,

              )
            ],
          ),
        ),
      ),
    );
  }
}
