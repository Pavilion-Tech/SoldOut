import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_states.dart';
import 'package:soldout/modules/buyer/widgets/home/auction_item.dart';
import 'package:soldout/modules/widgets/loadings/grid_view_loading/grid_view_loading.dart';
import '../../../../models/buyer_model/home_model/new_auctions_model.dart';
import '../../../../shared/components/constants.dart';
import '../auction/categories.dart';
import '../../../widgets/my_container.dart';

class AuctionsList extends StatelessWidget {
  AuctionsList({required this.newAuctions});

  List<AuctionModel> newAuctions;

  @override
  Widget build(BuildContext context) {
    AuctionCubit.get(context).currentCategory(
        newAuctions, newAuctions[0].categoryId!
    );
    var currentAspectRatio =  size!.height > 600 ?2.1:1.9;
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuctionCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoryAuctions != null,
          fallback: (context) => GridViewLoading(),
          builder: (context) => MyContainer(
            noSize: true,
            Column(
              children: [
                CategoryListViewAutions(newAuctions: newAuctions),
                ConditionalBuilder(
                  condition: cubit.categoryAuctions!.isNotEmpty,
                  fallback: (context) => Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: size!.height * .4,
                      ),
                      Text(tr('no_auctions')),
                    ],
                  )),
                  builder: (context) => GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: size!.width / (size!.height / currentAspectRatio),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    children: List.generate(
                      cubit.categoryAuctions!.length,
                      (index) => AuctionItem(
                        model: cubit.categoryAuctions![index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
