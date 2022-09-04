import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../widgets/order/suffix_widget.dart';
import '../../widgets/order/vendor_order_item_widget.dart';

class VendorOrderScreen extends StatelessWidget {
  const VendorOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          myAppBar(context: context, title: tr('my_orders')),
          MyContainer(
              Column(
            children: [
              defaultTextField(
                  controller: TextEditingController(),
                  hint: tr('search_by_order'),
                  suffix:SuffixWidget()),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index)=>OrderItem(),
                separatorBuilder: (context,index)=>SizedBox(height: 10,),
                itemCount: 6,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
