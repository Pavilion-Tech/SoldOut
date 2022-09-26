import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../widgets/vendor_settings_widgets/vendor_settings_wiget.dart';

class VendorSettingsScreen extends StatelessWidget {
  const VendorSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        myAppBar(context: context, title: tr('settings')),
        SingleChildScrollView(
          physics:const NeverScrollableScrollPhysics(),
          child: MyContainer(
              const VSettingsWidget(),
          ),
        ),
      ],
    );
  }
}
