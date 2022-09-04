import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/product_item.dart';
import 'package:soldout/modules/buyer/widgets/sort/suffix.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/my_container.dart';

class GridViewWidget extends StatelessWidget {

  GridViewWidget({Key? key,this.products}) : super(key: key);

  List<ProductModel>? products;

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      childAspectRatio: size!.width / (size!.height / 2.1),
      mainAxisSpacing: 16,
      crossAxisSpacing: 5,
      crossAxisCount: 2,
      children: List.generate(
        products!.length, (index) => ProductItem(
          product:products![index]
      ),
      ),
    );
  }

}


