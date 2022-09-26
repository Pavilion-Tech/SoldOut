import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import '../../../widgets/my_container.dart';
import '../../auth/sign_in/sign_in_screen.dart';
import '../../widgets/settings/settings_widgets/settings_wiget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: token != null,
      fallback: (context)=>SignInScreen(isNoty: true),

      builder: (context)=> SingleChildScrollView(
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
                const SettingsWiget(),
                noSize: true
            ),

          ],
        ),
      ),
    );
  }
}
