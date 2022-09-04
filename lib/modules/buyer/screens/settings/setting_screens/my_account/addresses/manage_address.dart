import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../widgets/my_container.dart';
import '../../../../../widgets/settings/settings_screens_widgets/address_widgets/manage_address_widget.dart';

class ManageAddress extends StatelessWidget {
  const ManageAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
              context: context,
              title: tr('manage_address'),
              isLastIcon: true,
              isArrowBack: true,
              lastIcon: Icons.shopping_cart,
              lastButtonTap: (){
                BuyerCubit.get(context).changeIndex(2);
                navigateAndFinish(context, BuyerLayout());
              }
            ),
            MyContainer(
                ManageAddressWidget(),
                noSize: true),
          ],
        ),
      ),
    );
  }
}
