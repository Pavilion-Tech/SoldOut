import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InvoiceWidget extends StatelessWidget {

  InvoiceWidget({
    this.padding = 20,
    this.isBuyPoints = false,
    this.orderTotal,
    this.shippingCharges,
    this.subTotal
  });

  double padding;
  bool  isBuyPoints;
  int? subTotal;
  int? shippingCharges;
  int? orderTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('invoice'),
            style:const  TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          ),
          const SizedBox(height: 10,),
          Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 18),
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withOpacity(.4),
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Column(
              children: [
                if(!isBuyPoints)
                  Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          tr('sub_total'),
                          style:const  TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                '$subTotal ${tr('sar')}',
                                style:const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              tr('vat'),
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.grey.shade400,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 25,),

                    Row(
                      children: [
                        Text(
                            tr('shipping_charges'),
                            style:const  TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text(
                            '$shippingCharges ${tr('sar')}',
                            style:const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),

                    const SizedBox(height: 20,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      tr('order_total'),
                      style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '$orderTotal ${tr('sar')}',
                      style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
