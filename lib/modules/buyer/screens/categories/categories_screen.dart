import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/buyer_model/product_model/product_model.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../widgets/items_shared/grid_view.dart';
import '../../widgets/sort/suffix.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({required this.products,required this.name});

  List<ProductModel> products;
  String name;

  TextEditingController searchController = TextEditingController();

  Suffix? suffix;
  @override
  Widget build(BuildContext context) {
    suffix = Suffix(apply:(){
      print(suffix!.sort!.sortValue);
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            myAppBar(
              context: context,
              isArrowBack: true,
              title: name,
              isLastIcon: true,
              lastIcon: Icons.shopping_cart,
              lastButtonTap: () {
                BuyerCubit.get(context).currentIndex = 2 ;
                navigateAndFinish(context, BuyerLayout());
              },
            ),
            MyContainer(
              noSize: true,
               Column(
                children: [
                  defaultTextField(
                      controller: searchController,
                      hint: tr('search_by_product'),
                      suffix:suffix
                  ),
                  GridViewWidget(products: products),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
