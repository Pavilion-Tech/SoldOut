import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/reset_dialog.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_widget.dart';

import '../../../../../shared/components/components.dart';
import '../../../../widgets/my_container.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key}) : super(key: key);


  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: myAppBar(
              context:context,
              title:tr('reset_password'),
              isArrowBack: true,
            ),
          ),
          MyContainer(
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepWidget(
                    title: tr('step_three_of_three'),
                    description:tr('enter_password'),
                  ),
                  SizedBox(height: 30,),
                  defaultTextField(
                      hint: tr('password'),
                      controller: passwordController,
                      suffix: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.visibility))
                  ),
                  SizedBox(height: 10,),
                  defaultTextField(
                      hint: tr('confirm_password'),
                      controller: cPasswordController,
                      suffix: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.visibility))
                  ),
                  SizedBox(height: 10,),
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: defaultButton(onTap: (){
                        showDialog(context: context, builder: (context){
                          return ResetDialog();
                        });
                      }, text: tr('reset_password')))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
