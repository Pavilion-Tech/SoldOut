import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/splash_screen.dart';

import '../../../../shared/components/constants.dart';
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
          style: const TextStyle(fontWeight: FontWeight.bold),),
        VMyAccountWidget(),
        Text(
          tr('our_app'),
          style: const TextStyle(fontWeight: FontWeight.bold),),
        VOurAppWidget(),
        BlocConsumer<VAuthCubit, VAuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Align(
              alignment: AlignmentDirectional.center,
              child:state is! LogOutLoadingState
              ? defaultButton(
                  onTap: () {
                    VAuthCubit.get(context).loginOut(context: context);
                  },
                  text: tr('logout')
              ) : const CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }
}
