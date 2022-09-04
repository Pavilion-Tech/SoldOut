import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';
import '../../auth/vendor_sign_in_screen.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      contentPadding:const  EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      content: Container(
        height: size!.height*.35,
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:  [
            const Icon(Icons.check_circle,color: Colors.green,size: 100,),
             Text(
               tr('account_created'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                height: 2,
                fontSize: 18
              ),
            ),
            TextButton(
                onPressed: (){
                  navigateTo(context, VSignInScreen());
                },
                child: Text(
                  tr('done'),
                  style:const TextStyle(fontWeight: FontWeight.bold),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
