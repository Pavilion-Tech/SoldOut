import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../widgets/sign_widget.dart';
import '../widgets/auth/vendor_signup_widget.dart';

class VSignUpScreen extends StatelessWidget {
  const VSignUpScreen({Key? key}) : super(key: key);

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
              title:tr('sign_up'),
              isArrowBack: true,
            ),
          ),
          SingleChildScrollView(
            child: SignWidget(
              isVSignUp: true,
              column: VSignUpWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
