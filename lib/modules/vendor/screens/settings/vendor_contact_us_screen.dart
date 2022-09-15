import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/widgets/contact_us_widget.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../widgets/my_container.dart';


class VContactUsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: 'CONTACT US',
                isArrowBack: true,
            ),
            MyContainer(
              ContactUsWidget(),
              end: 0,
              start: 0,
            ),
          ],
        ),
      ),
    );
  }
}
