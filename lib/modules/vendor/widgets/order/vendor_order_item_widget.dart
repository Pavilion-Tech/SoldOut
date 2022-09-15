import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/vendor_model/vendor_order_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../screens/order/vendor_purchases_details.dart';

class OrderItem extends StatelessWidget {

  OrderItem({required this.model});

  VendorOrderData model;

  late String time;

  @override
  Widget build(BuildContext context) {
    time =  DateFormat('',myLocale == 'ar'?'ar':'en')
        .add_yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(model.createdAt!));
    return InkWell(
      onTap: (){
        navigateTo(context, VPurchasesDetails(model: model,));
      },
      child: Container(
        height: size!.height * .09,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(
            color: Colors.grey.shade300.withOpacity(.5),
          ),
        ),
        padding: const EdgeInsetsDirectional.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${tr('orderHistory')}${model.id!}',
              style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            const Spacer(),
            Text(
              time,
              style:const TextStyle(color: Colors.grey,fontSize: 12),),
          ],
        ),
      ),
    );
  }
}
