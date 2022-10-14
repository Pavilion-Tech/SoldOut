import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../widgets/about_us_screen.dart';
import '../../../widgets/terms_conditions_screen.dart';
import '../../screens/settings/vendor_contact_us_screen.dart';

class VOurAppWidget extends StatelessWidget {
  const VOurAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: size!.height > 600 ?size!.height*.15:size!.height*.2,
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
              navigateTo(context, VContactUsScreen());
            }),
            const SizedBox(height: 10,),
            accountItem(tr('about_us'),(){
              navigateTo(context, AboutUsScreen(haveCart:false));
            }),
            const SizedBox(height: 10,),
            accountItem(tr('terms_conditions'),(){
              navigateTo(context, TermsAndConditionsScreen(haveCart:false));
            }),
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
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,size: 14,),
        ],
      ),
    );
  }
}
