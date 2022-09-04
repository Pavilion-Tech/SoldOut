import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/buyer_model/cart_model/get_checkout_model.dart';
import 'package:soldout/modules/buyer/widgets/check_out/invoice.dart';
import 'package:soldout/modules/buyer/widgets/check_out/list_store_item.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../../../../shared/components/constants.dart';

class PurchasesDetailsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size!.height * .14,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(
              color: Colors.grey.shade300.withOpacity(.5),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2015356',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size!.width*.7,
                      child: Text(
                    '18658 Tillman Plain, North Glennatown, Nevada, Peru',
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                  ))
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    tr('new_order'),
                    style:const TextStyle(color: defaultColor,fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    'Date: 20 Jun 2019',
                    style:const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),

            ],
          ),
        ),
        Padding(
          padding:const EdgeInsets.symmetric(vertical: 15),
          child: ListView.separated(
            itemBuilder: (context, index) => ListStoreItem(isCheckOut: false,),
            separatorBuilder: (context, index) =>const SizedBox(height: 10,),
            itemCount: 2,
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
          ),
        ),
        InvoiceWidget(padding: 0),
      ],
    );
  }
}
