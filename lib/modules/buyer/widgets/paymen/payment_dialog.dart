import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';

class PaymentCheckOutDialog extends StatefulWidget {

  PaymentCheckOutDialog(this.isSuccess);
  bool isSuccess;

  @override
  State<PaymentCheckOutDialog> createState() => _PaymentCheckOutDialogState();
}

class _PaymentCheckOutDialogState extends State<PaymentCheckOutDialog> with SingleTickerProviderStateMixin{


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
              child: ConditionalBuilder(
                condition: widget.isSuccess,
                fallback: (c)=>Icon(
                  Icons.error,
                  color: Colors.red,
                  size: animation.value,
                ),
                builder: (c)=>Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: animation.value,
                ),
              ),
            ),
            const  Spacer(),
            Text(
              tr(widget.isSuccess?'payment_successful':'ops_payment'),
              style:const  TextStyle(fontWeight: FontWeight.bold,),
            ),
            const  Spacer(),
            defaultButton(onTap: (){
              BuyerCubit.get(context).currentIndex = 0;
              CartCubit.get(context).getCart();
              navigateAndFinish(context, BuyerLayout());
            }, text: tr('go_home'),
                width: size!.height>670? null :size!.width
            ),
          ],
        ),
      ),
    );
  }
}
