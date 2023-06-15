import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_states.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_widget.dart';

import '../../../../../shared/components/components.dart';
import '../../../../widgets/my_container.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: myAppBar(
                context: context,
                title: tr('reset_password'),
                isArrowBack: true,
              ),
            ),
            BlocConsumer<VAuthCubit, VAuthStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = VAuthCubit.get(context);
                return MyContainer(
                  SingleChildScrollView(
                    physics:const NeverScrollableScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StepWidget(
                            title: tr('step_three_of_three'),
                            description: tr('enter_password'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextField(
                              hint: tr('password'),
                              controller: passwordController,
                              isPassword: cubit.resetPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return tr('password_empty');
                                }
                              },
                              suffix: IconButton(
                                  onPressed: () {
                                    cubit.changeResetVisibility();
                                  },
                                  icon: Icon(cubit.resetPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                          const SizedBox(height: 10),
                          defaultTextField(
                              hint: tr('confirm_password'),
                              controller: cPasswordController,
                              isPassword: cubit.resetCPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return tr('cPassword_empty');
                                }
                                if (value != passwordController.text) {
                                  return tr('cPassword_not_correct');
                                }
                              },
                              suffix: IconButton(
                                  onPressed: () {
                                    cubit.changeResetCVisibility();
                                  },
                                  icon: Icon(cubit.resetCPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: state is! ResetLoadingState
                                ? defaultButton(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.resetNewPassword(
                                          password:cPasswordController.text.trim() ,
                                            context: context
                                        );
                                      }
                                    },
                                    text: tr('reset_password'))
                                : const CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
