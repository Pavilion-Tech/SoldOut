import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/vendor/auth/auth_cubit/auth_states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';

class VSignUpWidget extends StatelessWidget {
  VSignUpWidget({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VAuthCubit, VAuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = VAuthCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: size!.height * .05,
              ),
              defaultTextField(
                  hint: tr('store_name'),
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr('store_empty');
                    }
                  }),
              SizedBox(
                height: size!.height * .01,
              ),
              defaultTextField(
                  hint: tr('phone'),
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
                  }),
              SizedBox(
                height: size!.height * .01,
              ),
              defaultTextField(
                  hint: tr('email_address_one'),
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr('email_empty');
                    }
                    if (!value.contains('@')) {
                      return tr('email_invalid');
                    }
                    if (!value.contains('.')) {
                      return tr('email_invalid');
                    }
                  }),
              SizedBox(
                height: size!.height * .01,
              ),
              defaultTextField(
                  hint: tr('password'),
                  controller: passwordController,
                  isPassword: cubit.password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr('password_empty');
                    }
                  },
                  suffix: IconButton(
                      onPressed: () {
                        cubit.changeVisibility();
                      },
                      icon: Icon(cubit.password
                          ? Icons.visibility
                          : Icons.visibility_off))),
              SizedBox(
                height: size!.height * .01,
              ),
              defaultTextField(
                  hint: tr('confirm_password'),
                  controller: cPasswordController,
                  isPassword: cubit.confirmPassword,
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
                        cubit.changeConfirmVisibility();
                      },
                      icon: Icon(cubit.confirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off))),
              SizedBox(
                height: size!.height * .01,
              ),
              defaultTextField(
                  hint: tr('attach_register'),
                  readOnly: true,
                  controller: cubit.attachRegister,
                  validator: (value){
                    if(value!.isEmpty){
                      return tr('commercial_empty');
                    }
                  },
                  onTap: () {
                    VAuthCubit.get(context).selectFile();
                  }),
              if(cubit.image!=null)
                SizedBox(
                height: size!.height * .01,
              ),
              if(cubit.image!=null)
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.file(
                  File(cubit.image!.path),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: size!.height * .01,
              ),
              state is! RegisterLoadingState
              ? defaultButton(
                text: tr('sign_up'),
                onTap: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                  if(formKey.currentState!.validate())
                  {
                    cubit.register(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      phone: phoneController.text.trim(),
                      password: passwordController.text.trim(),
                      context: context,
                    );
                  }
                  },
              ) : const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
