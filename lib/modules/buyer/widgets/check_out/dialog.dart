import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';

class CheckOutDialog extends StatefulWidget {
  CheckOutDialog({this.orderNum});

  int? orderNum;

  @override
  State<CheckOutDialog> createState() => _CheckOutDialogState();
}

class _CheckOutDialogState extends State<CheckOutDialog> with SingleTickerProviderStateMixin{


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
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      content: Container(
        height: size!.height*.3,
        alignment: AlignmentDirectional.center,
        child: Column(
          children:  [
            Container(
              height: 100,
              width: 100,
              alignment: AlignmentDirectional.center,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: animation.value,
              ),
            ),
            const  Spacer(),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                 TextSpan(
                   text: tr('order_successful'),
                   style:const  TextStyle(fontWeight: FontWeight.bold,),),
                 TextSpan(
                     text: '${widget.orderNum}',
                     style:const  TextStyle(color: Colors.blue,fontWeight: FontWeight.w900)),
                ]
              )
            ),
            const  Spacer(),
            defaultButton(onTap: (){
              BuyerCubit.get(context).currentIndex = 0;
              navigateAndFinish(context, BuyerLayout());
            }, text: tr('continue_shopping')),
          ],
        ),
      ),
    );
  }
}
