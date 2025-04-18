import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/grid_view.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../shared/components/constants.dart';

class ListArrivals extends StatelessWidget {

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
                  title: tr('new_arrivals'),
                  isArrowBack: true,
                  isLastIcon: true,
                  lastIcon: Icons.shopping_cart,
                  lastButtonTap: () {
                    BuyerCubit.get(context).changeIndex(2);
                    navigateAndFinish(context, BuyerLayout());
                  }
              ),
              MyContainer(
                ConditionalBuilder(
                  condition: cubit.homeModel!.data!.newProducts!
                      .isNotEmpty,
                  fallback: (context) =>
                      Column(
                        children: [
                          SizedBox(height: size!.height * .4),
                          Text(tr('no_arrivals'))
                        ],
                      ),
                  builder: (context) =>
                      GridViewWidget(
                        products: cubit.homeModel!.data!.newProducts!,
                        isScroll: true,
                      ),
                ),
                //noSize: true,
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
