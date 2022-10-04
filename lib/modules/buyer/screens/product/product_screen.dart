import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/widgets/loadings/show_product_loading/show_product_loading.dart';
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
      body: BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: product != null || state is GetProductSuccessState,
            fallback: (context)=>ProductLoading(),
            builder:(context)=> Stack(
              children: [
                MPageView(pageController:pageController,images:product!.images!),
                RowInTop(id: product!.id!),
                MIndicator(
                    pageController: pageController,
                    lengthPageView: product!.images!.length
                ),
                ProductDetails(product: product),
              ],
            ),
          );
        },
      ),
    );
  }

}
