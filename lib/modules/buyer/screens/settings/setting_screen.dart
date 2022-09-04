import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/my_container.dart';
import '../../widgets/settings/settings_widgets/settings_wiget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          myAppBar(
            context: context,
            title: tr('settings'),
            isLastIcon: true,
            lastIcon: Icons.shopping_cart,
            lastButtonTap: (){
              BuyerCubit.get(context).changeIndex(2);
            },
          ),
          MyContainer(
              SettingsWiget(),
              noSize: true
          ),

        ],
      ),
    );
  }
}
