import 'package:flutter/material.dart';
import 'package:soldout/shared/images/images.dart';
import '../../shared/components/constants.dart';

class SignWidget extends StatelessWidget {

  SignWidget({required this.column,this.isVSignUp = false,this.isVerify = false});

  Widget column;
  bool isVSignUp;
  bool isVerify;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:isVSignUp ? null: size!.height*.7,
      width: isVerify ? double.infinity: size!.width*.9,
      alignment:  AlignmentDirectional.topCenter,
      padding: const EdgeInsetsDirectional.only(top: 40,start: 10,end: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadiusDirectional.circular(10)
      ),
      child: Column(
        children: [
          if(!isVerify)
            Image.asset(
            BuyerImages.logo,
            width: size!.width*.4,
            height: size!.height*.1,
          ),
          column
        ],
      ),
    );
  }


}
