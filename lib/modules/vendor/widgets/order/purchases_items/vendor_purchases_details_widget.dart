import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/widgets/order/purchases_items/vendor_details_item.dart';
import 'package:soldout/modules/vendor/widgets/order/purchases_items/vendor_invoice.dart';
import 'package:soldout/shared/components/components.dart';
import 'vendor_list_item.dart';

class VPurchasesDetailsWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VPurchasesDetailsItem(),
        const SizedBox(height: 20,),
        VListStoreItem(),
        VInvoiceWidget(),
        defaultButton(onTap: () {}, text: tr('delivery'))
      ],
    );
  }
}
