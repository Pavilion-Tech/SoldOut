import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import 'package:soldout/shared/components/components.dart';

import 'myaccount_widget.dart';
import 'our_app_wiget.dart';

class SettingsWiget extends StatelessWidget {
  const SettingsWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr('my_account')),
        MyAccountWidget(),
        Text(tr('our_app')),
        OurAppWidget(),
        BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Align(
              alignment: AlignmentDirectional.center,
              child:state is SignOutLoadingState
                  ? const CircularProgressIndicator()
                  : defaultButton(
                  text: tr('logout'),
                  onTap: (){
                    AuthCubit.get(context).signOut(context);
                    BuyerCubit.get(context).currentIndex=0;
                  },
              ),
            );
          },
        )
      ],
    );
  }
}
