import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import '../../../../shared/components/constants.dart';
import 'auction_item.dart';

class ListAuctions extends StatelessWidget {
  const ListAuctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BuyerCubit.get(context);
        return Container(
            height:size!.height>736.0 ? size!.height * .20:size!.height * .23,
            alignment: AlignmentDirectional.centerStart,
            padding: EdgeInsetsDirectional.only(start: size!.width * .050),
            child: ConditionalBuilder(
              condition: cubit.homeModel!.data!.newAuctions!.isNotEmpty,
              fallback: (context) => Center(child: Text(tr('no_auctions'))),
              builder: (context) =>
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        AuctionItem(
                            model: cubit.homeModel!.data!.newAuctions![index],
                            isHome: true),
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          width: size!.width * .025,
                        ),
                    itemCount: cubit.homeModel!.data!.newAuctions!.length > 5
                        ? 5
                        : cubit.homeModel!.data!.newAuctions!.length,
                  ),
            ));
      },
    );
  }
}
