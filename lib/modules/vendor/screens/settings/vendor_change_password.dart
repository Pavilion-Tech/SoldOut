import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_cubit.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_states.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

class VChangePassword extends StatelessWidget {

  TextEditingController oldPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<VSettingCubit, VSettingStates>(
          listener: (context, state) {
            if(state is ChangePasswordSuccessState)Navigator.pop(context);
          },
          builder: (context, state) {
            var cubit = VSettingCubit.get(context);
            return InkWell(
              onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Stack(
                children: [
                  myAppBar(
                    context: context,
                    title: tr('change_password'),
                    isArrowBack: true,
                  ),
                  MyContainer(
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultTextField(
                              controller: oldPassword,
                              hint: tr('old_password'),
                              isPassword: cubit.oldPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return tr('oPassword_empty');
                                }
                              },
                              suffix: IconButton(
                                  onPressed: () {
                                    cubit.changeOldVisibility();
                                  },
                                  icon: Icon(cubit.oldPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off))
                          ),
                          const SizedBox(height: 15,),
                          defaultTextField(
                              hint: tr('new_password'),
                              controller: password,
                              isPassword: cubit.newPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return tr('nPassword_empty');
                                }
                              },
                              suffix: IconButton(
                                  onPressed: () {
                                    cubit.changeVisibility();
                                  },
                                  icon: Icon(cubit.newPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off))
                          ),
                          const SizedBox(height: 15,),
                          defaultTextField(
                              hint: tr('confirm_new_password'),
                              controller: passwordC,
                              isPassword: cubit.cNewPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return tr('cPassword_empty');
                                }
                                if (value != password.text) {
                                  return tr('cPassword_not_correct');
                                }
                              },
                              suffix: IconButton(
                                  onPressed: () {
                                    cubit.changeConfirmVisibility();
                                  },
                                  icon: Icon(cubit.cNewPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                          const SizedBox(height: 15,),
                          state is! ChangePasswordLoadingState
                          ? defaultButton(
                              onTap: () {
                                if(formKey.currentState!.validate()){
                                  VSettingCubit.get(context).changePassword(
                                      oldPassword: oldPassword.text,
                                      newPassword: passwordC.text);
                                }
                              },
                              text: tr('save')
                          ):const CircularProgressIndicator()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
