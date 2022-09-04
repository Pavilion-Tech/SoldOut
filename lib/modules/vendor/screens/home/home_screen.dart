import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../widgets/home/filter_widget.dart';
import '../../widgets/home/home_item_widget.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        myAppBar(context: context, title: 'Store Name'),
        MyContainer(
          Column(
            children: [
              FilterWidget(),
              SizedBox(height: 20,),
              HomeItemWidget(
                title: tr('product_count'),
                count: '350 ${tr('product')}',
                circleColor: defaultColor,
              ),
              SizedBox(height: 20,),
              HomeItemWidget(
                title: tr('order_count'),
                count: '340 ${tr('order')}',
                circleColor: Colors.indigoAccent,
              ),
              SizedBox(height: 20,),
              HomeItemWidget(
                title: tr('total_revenue'),
                count: '340 ${tr('sar')}',
                circleColor: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
