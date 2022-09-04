import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import 'package:soldout/shared/components/components.dart';

class EditProfileWidget extends StatelessWidget {
  EditProfileWidget({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        nameController.text = cubit.getProfileModel!.data!.name!;
        phoneController.text = cubit.getProfileModel!.data!.phone!;
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      tr('personal_information'),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 30,),
                defaultTextField(
                    controller: nameController,
                    hint: tr('full_name_two'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name Must Be Empty';
                      }
                    }
                ),
                SizedBox(height: 15,),
                defaultTextField(
                    controller: phoneController,
                    hint: tr('phone_sign_in'),
                    color: Colors.grey.shade200,
                    readOnly: true
                ),
                SizedBox(height: 15,),
                defaultButton(
                    onTap: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      AuthCubit.get(context).updateProfile(nameController.text.trim());
                      AuthCubit.get(context).getProfile();
                    },
                    text: tr('save'))
              ],
            ),
          ),
        );
      },
    );
  }
}
