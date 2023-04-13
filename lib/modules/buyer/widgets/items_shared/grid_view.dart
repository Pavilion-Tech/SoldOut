import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/product_item.dart';
import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';

class GridViewWidget extends StatelessWidget {

  GridViewWidget({Key? key,this.products}) : super(key: key);

  List<ProductModel>? products;

  @override
  Widget build(BuildContext context) {
    var currentAspectRatio =  size!.height > 736.0 ?2.1:1.9;
    return GridView.count(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      childAspectRatio: size!.width / (size!.height / currentAspectRatio),
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


