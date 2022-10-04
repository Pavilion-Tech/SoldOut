import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/widgets/check_out/invoice.dart';
import 'package:soldout/modules/buyer/widgets/settings/settings_screens_widgets/order_widgets/store_order.dart';
import '../../../../../../models/buyer_model/order_model.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../auction/auction_checkout_item.dart';

class PurchasesDetailsWidget extends StatelessWidget {

  PurchasesDetailsWidget({required this.model});

  OrderData model;

  late String time ;

  @override
  Widget build(BuildContext context) {
    time = DateFormat('',myLocale == 'ar'?'ar':'en')
        .add_yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(model.createdAt!));
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
                '${model.id}',
                style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.blue,),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: size!.width*.7,
                      child: Text(
                        model.shippingAddress!,
                        style:const TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                  ))
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    time,
                    style:const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),

            ],
          ),
        ),
        if(model.auctionOrder==null)
          Padding(
          padding:const EdgeInsets.symmetric(vertical: 15),
          child: ListView.separated(
            itemBuilder: (context, index) => StoreOrderItem(stores: model.stores![index]),
            separatorBuilder: (context, index) =>const SizedBox(height: 10,),
            itemCount: model.stores!.length,
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
          ),
        ),
        if(model.auctionOrder!=null)
          AuctionCheckOutItem(
              model.auctionOrder!.productName!,
              model.auctionOrder!.auctionName!,
              model.auctionOrder!.firstImage!,
          ),
        InvoiceWidget(
        subTotal: model.subTotal,
        shippingCharges: model.totalShippingCharges,
        orderTotal: model.totalOrderPrice,
        padding: 0
        ),
      ],
    );
  }
}
