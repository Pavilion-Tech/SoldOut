import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../../../models/vendor_model/vendor_order_model.dart';

class VInvoiceWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('invoice'),
            style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('sub_total'),
                        style:const TextStyle(fontWeight: FontWeight.bold),),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              '10 ${tr('sar')}',
                              style:const TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: defaultColorTwo,
                  ),),
                Row(
                    children: [
                      Text(
                          tr('shipping_charges'),
                          style:const TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text('10 ${tr('sar')}',style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: defaultColorTwo,
                  ),),
                Row(
                  children: [
                    Text(
                      tr('order_total'),
                      style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    const Spacer(),
                    Text(
                      '20 ${tr('sar')}',
                      style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
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
