import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../widgets/about_us_screen.dart';
import '../../../screens/settings/setting_screens/our_app/contact_us_screen.dart';
import '../../../../widgets/terms_conditions_screen.dart';

class OurAppWidget extends StatelessWidget {
  const OurAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: size!.height*.2,
        padding: const EdgeInsetsDirectional.all(5),
        decoration: BoxDecoration(
            color: Colors.blue.shade100.withOpacity(.1),
            borderRadius: BorderRadiusDirectional.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            accountItem(tr('contact_us'),(){
              navigateTo(context,const ContactUsScreen());
            }),
            const SizedBox(height: 10,),
            accountItem(tr('about_us'),(){
              navigateTo(context, AboutUsScreen());
            }),
            const SizedBox(height: 10,),
            accountItem(tr('terms_conditions'),(){
              navigateTo(context, TermsAndConditionsScreen());
            }),
            Row(
              children: [
                Text(tr('powered_by')),
                SizedBox(
                  height: 60,
                  width: 100,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Positioned(
                        bottom: 28,
                        right: 80,
                        child: Image.asset(BuyerImages.productBy1,height: 20,width: 20,),
                      ),
                      Positioned(
                          top: 15,
                          left: 5,
                          child: Image.asset(BuyerImages.productBy2,height: 30,width: 30,)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget accountItem(String title, VoidCallback callback){
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,size: 14,),
        ],
      ),
    );
  }
}
