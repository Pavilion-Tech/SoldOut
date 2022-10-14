import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/widgets/contact_us_widget.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../widgets/my_container.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          myAppBar(
              context: context,
              title: tr('contact_us'),
              isArrowBack: true,
              isLastIcon: true,
              lastIcon: Icons.shopping_cart,
              lastButtonTap: () {
                BuyerCubit.get(context).changeIndex(2);
                navigateAndFinish(context, BuyerLayout());
              }),
          MyContainer(
            ContactUsWidget(),
            end: 0,
            start: 0,
            noSize: true,
          ),
        ],
      ),
    ));
  }
}
