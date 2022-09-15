import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/widgets/order/purchases_items/vendor_details_item.dart';
import 'package:soldout/modules/vendor/widgets/order/purchases_items/vendor_invoice.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../../models/vendor_model/vendor_order_model.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../buyer/widgets/check_out/invoice.dart';
import '../../../../widgets/track_order.dart';
import 'vendor_list_item.dart';

class VPurchasesDetailsWidget extends StatelessWidget {

  VPurchasesDetailsWidget({required this.model});

  VendorOrderData model;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VPurchasesDetailsItem(model: model),
        const SizedBox(height: 20,),
        if(model.status == 'rejected')
          orderReject(),
        if(model.status != 'rejected')
          TrackOrder(status: model.status!),
        const SizedBox(height: 20,),
        VListStoreItem(products: model.products!),
        InvoiceWidget(
            subTotal: model.subTotal,
            shippingCharges: model.totalShippingCharges,
            orderTotal: model.totalOrderPrice,
            padding: 0
        ),
        const SizedBox(height: 20,),
        defaultButton(onTap: () {}, text: tr('delivery'))
      ],
    );
  }

  Widget orderReject()
  {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(5),
          color: Colors.red
      ),
      child: Text(
        tr('rejected'),
        style:const TextStyle(
            color:defaultColorTwo,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
