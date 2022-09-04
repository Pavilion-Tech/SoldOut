import 'package:flutter/material.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../screens/order/vendor_purchases_details.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, VPurchasesDetails());
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
            Text('Order #2015356',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            Spacer(),
            Row(
              children: [
                Text('Date: 20 Jun 2019',style: TextStyle(color: Colors.grey,fontSize: 12),),
                Spacer(),
                Text('New Order',style: TextStyle(color: Colors.blue,fontSize: 12,fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
