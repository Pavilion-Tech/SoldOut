import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';

import '../../../../../../shared/components/constants.dart';
import '../../../../screens/check_out/cart_check_out.dart';
import '../../../../screens/check_out/point_check_out.dart';


class FirstTap extends StatelessWidget {
  const FirstTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, PointsCheckOutScreen()),
      child: Container(
        alignment: AlignmentDirectional.center,
        child: Container(
          height: size!.height*.13,
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color: Colors.grey.shade300)
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    tr('your_package'),
                    style:const TextStyle(color: Colors.grey,fontSize: 12,),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    '1500 ${tr('sar')} | 300 Coins',
                    style:const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 40,
                  width: 40,
                  child: Image.asset(BuyerImages.points,height: 40,width: 40,))
            ],
          ),
        ),
      ),
    );
  }
}
