import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_two.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_widget.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

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
              title:tr('forget_password'),
              isArrowBack: true,
            ),
          ),
          MyContainer(
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  StepWidget(
                    title: tr('step_one_of_three'),
                    description:tr('enter_email'),
                  ),
                  const SizedBox(height: 30,),
                  defaultTextField(
                      controller: TextEditingController(),
                      hint: tr('email_address_one'),
                  ),
                  const SizedBox(height: 30,),
                  defaultButton(
                      onTap: (){
                        navigateTo(context, VerficationCode());
                      },
                      text: tr('next')
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
