import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_states.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_one.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../auth/vendor_sign_up_screen.dart';

class VSignInWidget extends StatelessWidget {
  VSignInWidget({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VAuthCubit, VAuthStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);

      },
      builder: (context, state) {
        var cubit = VAuthCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: size!.height * .05,),
              defaultTextField(
                  hint: tr('phone_sign_in'),
                  controller: phoneController,
                  type: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return tr('phone_empty');
                  }
                },
              ),
              SizedBox(height: size!.height * .01,),
              defaultTextField(
                  hint: tr('password'),
                  controller: passwordController,
                  isPassword: cubit.passwordLogin,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr('password_empty');
                    }
                  },
                  suffix: IconButton(
                      onPressed: () {
                        cubit.changeLoginVisibility();
                      },
                      icon: Icon(cubit.passwordLogin
                          ? Icons.visibility
                          : Icons.visibility_off))),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                    onPressed: () {
                      navigateTo(context, ForgetPassword());
                    },
                    child: Text(
                      tr('forget_password'),
                      style: const TextStyle(fontWeight: FontWeight.w700),)
                ),
              ),
              SizedBox(height: size!.height * .015,),
              state is! LoginLoadingState
              ?defaultButton(
                text: tr('sign_in'),
                onTap: () {
                if(formKey.currentState!.validate()){
                  FocusManager.instance.primaryFocus!.unfocus();
                  cubit.login(
                      phone: phoneController.text,
                      password: passwordController.text,
                      context: context
                  );
                }
                },)
              :const CircularProgressIndicator(),
              SizedBox(height: size!.height * .01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('dont_have_account'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      navigateTo(context,const VSignUpScreen());
                    },
                    child: Text(
                      tr('sign_up'),
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
