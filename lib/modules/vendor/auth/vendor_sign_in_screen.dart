import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/components.dart';
import '../../widgets/sign_widget.dart';
import '../widgets/auth/vendor_signin_widget.dart';

class VSignInScreen extends StatelessWidget {



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
              title:tr('sign_in'),
              isArrowBack: true,
            ),
          ),
          SignWidget(
            column: SingleChildScrollView(child: VSignInWidget()),
          ),
        ],
      ),
    );
  }

}
