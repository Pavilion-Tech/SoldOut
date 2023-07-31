import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/grid_view.dart';
import 'package:soldout/modules/widgets/loadings/grid_view_loading/grid_view_loading.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../shared/components/constants.dart';


class Favorites extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyerCubit.get(context);
          return Stack(
            children: [
              myAppBar(
                  context: context,
                  title: tr('my_fav'),
                  isArrowBack: true,
                  isLastIcon: true,
                  lastIcon: Icons.shopping_cart,
                  lastButtonTap: () {
                    BuyerCubit.get(context).changeIndex(2);
                    navigateAndFinish(context, BuyerLayout());
                  }
              ),
              ConditionalBuilder(
                  condition: cubit.getFavModel != null,
                  fallback: (context) => GridViewLoading(),
                  builder: (context) =>
                      MyContainer(
                        cubit.getFavModel!.data!.products!.isNotEmpty
                            ? Expanded(
                              child: GridViewWidget(
                          products: cubit.getFavModel!.data!.products,
                                isScroll: true,
                              ),
                            ) : Column(
                          children: [
                            SizedBox(height: size!.height * .4),
                            Text(tr('no_fav'))
                          ],
                        ),
                        noSize: true,)

              ),
              Container(
                width: size!.width,
                height: size!.height,
                child: cubit.flyingCart == null ? Container() : cubit.flyingCart,
              )
            ],
          );
        },
      ),
    );
  }
}
