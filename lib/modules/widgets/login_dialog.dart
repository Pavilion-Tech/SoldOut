import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/auth/sign_in/sign_in_screen.dart';
import 'package:soldout/modules/buyer/widgets/auction/points_dialog.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../vendor/auth/vendor_sign_in_screen.dart';

class LoginDialog extends StatefulWidget {

  LoginDialog({this.isUser = true});

  bool isUser;

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> with SingleTickerProviderStateMixin{


  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller)
      ..addListener(() {
        setState(() {
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      content: Container(
        height: size!.height>670? size!.height*.3:size!.height*.4,
        alignment: AlignmentDirectional.center,
        child: Column(
          children:  [
            Container(
              height: 100,
              width: 100,
              alignment: AlignmentDirectional.center,
              child: Icon(
                Icons.login,
                color: Colors.red,
                size: animation.value,
              ),
            ),
            const  Spacer(),
            Text(
            'must_log_in_again'.tr(),
            style:const  TextStyle(fontWeight: FontWeight.bold,)
            ),
            const  Spacer(),
            defaultButton(
              onTap: (){
                if(widget.isUser){
                  navigateTo(context, SignInScreen());
                }else{
                  navigateTo(context, VSignInScreen());
                }
              },
              text: 'sign_in'.tr(),
            )
          ],
        ),
      ),
    );
  }
}
