import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../shared/components/components.dart';
import '../../../splash_screen.dart';

class UpdateScreen extends StatelessWidget {

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
              Image.asset(BuyerImages.update),
              Column(
                children: [
                  Text(
                    tr('update'),
                    style:const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    tr('update_note'),
                    textAlign: TextAlign.center,
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
                text: tr('update_now'),
                width: double.infinity,

              )
            ],
          ),
        ),
      ),
    );
  }
}
