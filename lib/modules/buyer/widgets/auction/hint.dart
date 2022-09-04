import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size!.height * .11,
      left: myLocale == 'ar' ? 0 : size!.width * .38,
      child: Container(
        width: size!.width * .6,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: defaultColor,
        ),
        padding:const EdgeInsetsDirectional.only(
            top: 10,
            start: 10,
            end: 5,
            bottom: 5
        ),
        child: Column(
          children: [
            Row(
              children:  [
                Text(
                  tr('press+'),
                  style:const TextStyle(
                      color: defaultColorTwo,
                      fontSize: 10),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                      BuyerCubit.get(context).changeAuctionHint();
                  },
                  child:const CircleAvatar(
                    radius: 12,
                    backgroundColor: defaultColorTwo,
                    child:Text('x',style: TextStyle(height: 01,fontWeight: FontWeight.w900,color: defaultColor),),
                  ),
                ),
              ],
            ),
            Text(
              tr('will_deducted'),
              style:const TextStyle(
                  color: defaultColorTwo,
                  fontSize: 10),
            ),
            Text(
              tr('points_refunded'),
              style:const TextStyle(
                  color: defaultColorTwo,
                  fontSize: 10,
                  fontWeight: FontWeight.w900
              ),
            ),
          ],
        ),
      ),
    );
  }
}
