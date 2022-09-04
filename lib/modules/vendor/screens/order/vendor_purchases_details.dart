import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/my_container.dart';
import '../../widgets/order/purchases_items/vendor_purchases_details_widget.dart';

class VPurchasesDetails extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: '${tr('purchases_details')}5925437',
                isArrowBack: true,
            ),
            MyContainer(
                VPurchasesDetailsWidget(),
                noSize: true),
          ],
        ),
      ),
    );
  }
}
