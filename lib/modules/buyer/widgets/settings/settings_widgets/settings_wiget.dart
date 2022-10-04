import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
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
        const MyAccountWidget(),
        Text(tr('our_app')),
        const OurAppWidget(),
        BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Align(
              alignment: AlignmentDirectional.center,
              child:Column(
                children:
                [
                  state is SignOutLoadingState
                      ? const CircularProgressIndicator()
                      : defaultButton(
                    text: tr('logout'),
                    onTap: (){
                      CartCubit.get(context).getCartModel=null;
                      AuthCubit.get(context).signOut(context,0);
                      BuyerCubit.get(context).currentIndex=0;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextButton(
                    onPressed: (){
                      CartCubit.get(context).getCartModel=null;
                      AuthCubit.get(context).signOut(context,1);
                      BuyerCubit.get(context).currentIndex=0;
                    },
                    child: Text(
                        tr('delete_acc'),
                      style:const TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
            );
          },
        ),

      ],
    );
  }
}
