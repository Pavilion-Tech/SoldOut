import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/widgets/auth/sign_up_dialog.dart';

import '../../../../layout/vendor_layout/cubit/vendor_cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';

class VSignUpWidget extends StatelessWidget {
   VSignUpWidget({Key? key}) : super(key: key);


  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: size!.height*.05,),
        defaultTextField(
          hint: tr('store_name'),
          controller: nameController,
        ),
        SizedBox(height: size!.height*.01,),
        defaultTextField(
            hint: tr('phone'),
            controller: phoneController,
            type: TextInputType.phone
        ),
        SizedBox(height: size!.height*.01,),
        defaultTextField(
            hint: tr('email_address_one'),
            controller: emailController,
            type: TextInputType.phone
        ),
        SizedBox(height: size!.height*.01,),
        defaultTextField(
            hint: tr('password'),
            controller: passwordController,
            suffix: IconButton(
                onPressed: (){},
                icon: Icon(Icons.visibility))
        ),
        SizedBox(height: size!.height*.01,),
        defaultTextField(
            hint: tr('confirm_password'),
            controller: cPasswordController,
            suffix: IconButton(
                onPressed: (){},
                icon: Icon(Icons.visibility))
        ),
        SizedBox(height: size!.height*.01,),
        defaultTextField(
            hint: tr('attach_register'),
            controller: phoneController,
            readOnly: true,
            onTap: (){
            VendorCubit.get(context).selectFile();
            }
        ),
        SizedBox(height: size!.height*.01,),
        defaultButton(onTap: (){
          showDialog(context: context, builder: (context){
            return SignUpDialog();
          });
        }, text: tr('sign_up')),
      ],
    );
  }
}
