import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/product_item.dart';

import '../../../../shared/components/constants.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BuyerCubit.get(context);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context,index)=>SizedBox(width: size!.width * .020,),
      itemCount: cubit.homeModel!.data!.newProducts!.length > 6
          ?6
          :cubit.homeModel!.data!.newProducts!.length,
      itemBuilder: (context,index)=>ProductItem(
          isGrid: false,
          product: cubit.homeModel!.data!.newProducts![index]),
    );
  }


}
