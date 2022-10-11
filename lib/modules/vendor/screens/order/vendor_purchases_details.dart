import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../models/vendor_model/vendor_order_model.dart';
import '../../../widgets/my_container.dart';
import '../../widgets/order/purchases_items/vendor_purchases_details_widget.dart';

class VPurchasesDetails extends StatelessWidget {

  VPurchasesDetails({required this.model});

  VendorOrderData model;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: '${tr('purchases_details')}${model.id}',
                isArrowBack: true,
            ),
            MyContainer(
                VPurchasesDetailsWidget(model:model),
                noSize: true),
          ],
        ),
      ),
    );
  }
}
