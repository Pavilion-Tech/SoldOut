import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/images/images.dart';

import '../../../shared/components/constants.dart';

class MaintanceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 80
          ),
          color:Colors.blue.shade100.withOpacity(.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(BuyerImages.ops),
              Column(
                children: [
                  Text(
                    tr('maintenance'),
                    style:const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    tr('maintenance_note'),
                    textAlign: TextAlign.center,
                    style:const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
              SizedBox(height: size!.height*.2,),
            ],
          ),
        ),
      ),
    );
  }
}
