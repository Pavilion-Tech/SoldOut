import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../widgets/items_shared/indicator.dart';
import '../../widgets/items_shared/page_veiw.dart';
import '../../widgets/prodect/product_details.dart';
import '../../widgets/prodect/row_in_top.dart';

class ProductScreen extends StatelessWidget {

  ProductScreen({this.product});

  PageController pageController = PageController();
  ProductModel? product;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MPageView(pageController: pageController,images: product!.images!),
          RowInTop(id: product!.id!),
          MIndicator(pageController: pageController,lengthPageView:product!.images!.length ),
          ProductDetails(product: product),
        ],
      ),
    );
  }

}
