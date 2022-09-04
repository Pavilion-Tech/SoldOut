import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../widgets/manage_product_widgets/edit_product.dart';

class VendorEditProductScreen extends StatelessWidget {
  const VendorEditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('edit_product'),
                isArrowBack: true
            ),
            MyContainer(
              noSize: true,
              EditProductWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
