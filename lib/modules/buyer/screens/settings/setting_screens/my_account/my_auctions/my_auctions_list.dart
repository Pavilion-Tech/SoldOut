import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_states.dart';
import 'package:soldout/modules/buyer/widgets/home/auction_item.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/suffix_widget.dart';
import 'package:soldout/modules/widgets/loadings/grid_view_loading/grid_view_loading.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../../../shared/components/constants.dart';
import '../../../../../../widgets/my_container.dart';

class MyAuctionList extends StatelessWidget {

  SuffixWidget suffixWidget = SuffixWidget();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuctionCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.myAuction != null,
          fallback: (context) => GridViewLoading(),
          builder: (context) => MyContainer(
            noSize: true,
            Column(
              children: [
                defaultTextField(
                  hint: tr('search_by_auction'),
                  suffix: suffixWidget,
                  onChanged: (value) {
                    if(value.isNotEmpty)
                    {
                      cubit.search(value);
                    }
                    if(value.isEmpty)
                    {
                      cubit.nullSearch();
                    }
                  }
                ),
                ConditionalBuilder(
                  condition: cubit.myAuction!.data!.isNotEmpty||cubit.searchModel!.isNotEmpty,
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
                    childAspectRatio: size!.width / (size!.height / 2.1),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    children: List.generate(
                      cubit.searchModel!=null
                         ?cubit.searchModel!.length
                         : cubit.myAuction!.data!.length,
                          (index) => AuctionItem(
                            model:cubit.searchModel!=null
                                ?cubit.searchModel![index]
                                : cubit.myAuction!.data![index],
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
