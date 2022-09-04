import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_one.dart';

import '../../../../layout/vendor_layout/vendor_layout_screen.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../auth/vendor_sign_up_screen.dart';

class VSignInWidget extends StatelessWidget {
   VSignInWidget({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size!.height*.05,),
        defaultTextField(
            hint: tr('phone_sign_in'),
            controller: phoneController,
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
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton(
              onPressed: (){
                navigateTo(context, ForgetPassword());
              },
              child:Text(
                tr('forget_password'),
                style:const TextStyle(fontWeight: FontWeight.w700),)
          ),
        ),
        SizedBox(height: size!.height*.015,),
        defaultButton(onTap: (){
          navigateTo(context, VendorLayout());
        }, text: tr('sign_in')),
        SizedBox(height: size!.height*.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr('dont_have_account'),
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: (){
                navigateTo(context, VSignUpScreen());
              },
              child:Text(
                tr('sign_up'),
                style:const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
