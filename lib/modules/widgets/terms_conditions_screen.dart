import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../buyer/screens/settings/settings_cubit/settings_cubit.dart';
import '../buyer/screens/settings/settings_cubit/settings_states.dart';
import 'loadings/about_app_loading/about_app_loading.dart';
import 'my_container.dart';


class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({this.haveCart = true});

  bool haveCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SettingsCubit.get(context);
          return SingleChildScrollView(
            child: Stack(
              children: [
                myAppBar(
                    context: context,
                    title: tr('terms_conditions'),
                    isArrowBack: true,
                    isLastIcon: haveCart,
                    lastIcon: Icons.shopping_cart,
                    lastButtonTap: () {
                      BuyerCubit.get(context).changeIndex(2);
                      navigateAndFinish(context, BuyerLayout());
                    }),
                MyContainer(
                  ConditionalBuilder(
                    condition: cubit.settingsModel != null,
                    fallback:(context)=>const AboutAppLoading(),
                    builder:(context)=> Text(
                      SettingsCubit.get(context).settingsModel!.data!.terms!,
                      style: TextStyle(height: 2, fontSize: 16),
                    ),
                  ),


                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
