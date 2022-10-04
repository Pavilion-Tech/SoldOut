import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';

class DiscountWidget extends StatelessWidget {

  DiscountWidget(this.isCart);

  TextEditingController couponController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late bool isCart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: defaultTextField(
            controller: couponController,
            hint: tr('enter_discount'),
            validator: (value) {
              if (value!.isEmpty) {
                return tr('coupon_empty');
              }
            },
            suffix: suffixWidget(context)),
      ),
    );
  }

  Widget suffixWidget(context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: size!.height * .03,
          width: 1,
          color: Colors.grey.shade200,
        ),
        SizedBox(
          width: size!.width * .05,
        ),
        TextButton(onPressed: () {
          if (formKey.currentState!.validate()) {
            if(isCart)
            {
              CartCubit.get(context).checkCoupon(
                  couponController.text.trim());
            } else
              {

              }
          }
        }, child: Text(tr('apply'))
        )
      ],
    );
  }
}
