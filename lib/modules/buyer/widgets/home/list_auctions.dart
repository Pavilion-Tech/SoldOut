import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';

import '../../../../shared/components/constants.dart';
import 'auction_item.dart';

class ListAuctions extends StatelessWidget {
  const ListAuctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index)=>
          AuctionItem(
              model: BuyerCubit.get(context).homeModel!.data!.newAuctions![index],
              isHome: true
          ),
      separatorBuilder: (context,index)=>SizedBox(width: size!.width * .025,),
      itemCount: BuyerCubit.get(context).homeModel!.data!.newAuctions!.length > 5
          ?5
          :BuyerCubit.get(context).homeModel!.data!.newAuctions!.length,
    );
  }


}
