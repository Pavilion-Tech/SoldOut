import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import 'vendor_myaccount_widget.dart';
import 'vendor_our_app_wiget.dart';

class VSettingsWiget extends StatelessWidget {
  const VSettingsWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('my_account'),
          style:const TextStyle(fontWeight: FontWeight.bold),),
        VMyAccountWidget(),
        Text(
          tr('our_app'),
          style:const TextStyle(fontWeight: FontWeight.bold),),
        VOurAppWidget(),
        Align(
          alignment: AlignmentDirectional.center,
          child: defaultButton(onTap: (){}, text: tr('logout')),
        )
      ],
    );
  }
}
