import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../widgets/my_container.dart';
import '../../../../../widgets/settings/settings_screens_widgets/order_widgets/purchases_details_widget.dart';

class PurchasesDetails extends StatelessWidget {


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
                isLastIcon: true,
                lastIcon: Icons.shopping_cart,
                lastButtonTap: () {
                  BuyerCubit.get(context).changeIndex(2);
                  navigateAndFinish(context, BuyerLayout());
                }
            ),
            MyContainer(
                PurchasesDetailsWidget(),
                noSize: true
            ),
          ],
        ),
      ),
    );
  }
}
