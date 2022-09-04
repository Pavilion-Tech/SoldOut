import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../shared/components/constants.dart';

class SignWidget extends StatelessWidget {

  SignWidget({required this.column});

  Widget column;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height*.7,
      width: size!.width*.9,
      alignment:  AlignmentDirectional.topCenter,
      padding: const EdgeInsetsDirectional.only(top: 40,start: 10,end: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadiusDirectional.circular(10)
      ),
      child: Column(
        children: [
          Image.asset(
            BuyerImages.splashLogo,
            width: size!.width*.4,
            height: size!.height*.1,
          ),
          column
        ],
      ),
    );
  }


}
