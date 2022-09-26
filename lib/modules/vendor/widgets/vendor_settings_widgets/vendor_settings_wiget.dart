import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'vendor_myaccount_widget.dart';
import 'vendor_our_app_wiget.dart';

class VSettingsWidget extends StatelessWidget {
  const VSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('my_account'),
          style: const TextStyle(fontWeight: FontWeight.bold),),
        const VMyAccountWidget(),
        Text(
          tr('our_app'),
          style: const TextStyle(fontWeight: FontWeight.bold),),
        const VOurAppWidget(),
        BlocConsumer<VAuthCubit, VAuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Align(
              alignment: AlignmentDirectional.center,
              child:state is! LogOutLoadingState
              ? Column(
                children: [
                  defaultButton(
                      onTap: () {
                        VAuthCubit.get(context).loginOut(
                            context: context,
                            deleteAccount: 0
                        );
                      },
                      text: tr('logout')
                  ),
                  const SizedBox(height: 20,),
                  TextButton(
                    onPressed: (){
                      VAuthCubit.get(context).loginOut(
                          context: context,
                          deleteAccount: 1
                      );
                    },
                    child: Text(
                      tr('delete_acc'),
                      style:const TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ) : const CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }
}
