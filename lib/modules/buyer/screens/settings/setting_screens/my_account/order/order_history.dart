import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../../widgets/my_container.dart';
import '../../../../../widgets/settings/settings_screens_widgets/order_widgets/order_history_widget.dart';


class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('my_order_history'),
                isArrowBack: true,
                isLastIcon: true,
                lastIcon: Icons.shopping_cart,
                lastButtonTap: () {
                  BuyerCubit.get(context).changeIndex(2);
                  navigateAndFinish(context, BuyerLayout());
                }
                ),
            MyContainer(
                OrderHistoryWidget(),
                ),
          ],
        ),
      ),
    );
  }
}
