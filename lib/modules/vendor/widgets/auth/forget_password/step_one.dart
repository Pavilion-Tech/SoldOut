import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_states.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_widget.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../auth/vendor_verfication.dart';


class ForgetPassword extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: myAppBar(
              context: context,
              title: tr('forget_password'),
              isArrowBack: true,
            ),
          ),
          BlocConsumer<VAuthCubit, VAuthStates>(
            listener: (context, state) {
              if(state is RequestResetSuccessState)
              {
                navigateTo(context, VVerificationScreen(isStepTwo: true,));
              }
            },
            builder: (context, state) {
              return MyContainer(
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      StepWidget(
                        title: tr('step_one_of_three'),
                        description: tr('enter_phone'),
                      ),
                      const SizedBox(height: 30,),
                      defaultTextField(
                          type: TextInputType.phone,
                          controller: VAuthCubit.get(context).phoneC,
                          digitsOnly: true,
                          textLength: 10,
                          hint: tr('phone_sign_in'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return tr('phone_empty');
                            }
                          }
                      ),
                      const SizedBox(height: 30,),
                      state is! RequestResetLoadingState
                      ?defaultButton(
                          onTap: () {
                            VAuthCubit.get(context).requestReset();
                          },
                          text: tr('next')
                      ):const CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
