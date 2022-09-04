import 'package:flutter/material.dart';

import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/images/images.dart';

class SecondTap extends StatelessWidget {
  const SecondTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      child: Container(
        height: size!.height*.2,
        width: size!.width*.75,
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color: Colors.grey.shade300)
        ),
        child: Column(
          children: [
            Container(
                height: 70,
                width: 70,
                child: Image.asset(BuyerImages.points,height: 70,width: 70,)),
            SizedBox(height: 30,),
            Text.rich(
              TextSpan(
                  children: [
                    TextSpan(text: '300 Coins ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                    TextSpan(text: '(50 Coins Left)',style: TextStyle(color: Colors.grey,decoration: TextDecoration.underline))
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
