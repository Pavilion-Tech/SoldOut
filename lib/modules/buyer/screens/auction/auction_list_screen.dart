import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../shared/components/components.dart';
import '../../widgets/items_shared/other_list_auction.dart';

class AuctionsListScreen extends StatelessWidget {
  const  AuctionsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('auction'),
                isArrowBack: true,
                isLastIcon: true,
                lastIcon: Icons.shopping_cart,
                lastButtonTap: (){
                  BuyerCubit.get(context).changeIndex(2);
                  navigateAndFinish(context, BuyerLayout());
                }
            ),
            OtherListAuctions(),
          ],
        ),
      ),
    );
  }
}
