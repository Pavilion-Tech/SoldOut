import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/images/images.dart';
import '../../../../screens/settings/settings_cubit/settings_cubit.dart';
import '../../../../screens/settings/settings_cubit/settings_states.dart';

class SecondTap extends StatelessWidget {
  const SecondTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return Container(
          alignment: AlignmentDirectional.topCenter,
          child: Container(
            height:size!.height>670? size!.height*.2:size!.height*.35,
            width: size!.width * .75,
            padding: const EdgeInsetsDirectional.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                border: Border.all(color: Colors.grey.shade300)),
            child: Column(
              children: [
                SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.asset(
                      BuyerImages.points,
                      height: 70,
                      width: 70,
                    )),
                const SizedBox(height: 30,),
                Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                            text: '${cubit.getPointsModel!.data!.lastPackageCoins} ${tr('coin')} ',
                            style:const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)
                        ),
                        TextSpan(
                            text: '(${cubit.getPointsModel!.data!.leftCoins} ${tr('coin_left')})',
                            style:const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline)
                        )
                      ]
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
