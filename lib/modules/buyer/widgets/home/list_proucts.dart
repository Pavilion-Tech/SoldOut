import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/product_item.dart';
import '../../../../shared/components/constants.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BuyerCubit.get(context);
    return Container(
      height:size!.height >736.0 ? size!.height * .2:size!.height * .225,
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsetsDirectional.only(start: size!.width * .050),
      child: ConditionalBuilder(
        condition: cubit.homeModel!.data!.newProducts!.isNotEmpty,
        fallback: (context) => Center(
          child: Text(tr('no_arrivals')),
        ),
        builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
            width: size!.width * .020,
          ),
          itemCount: cubit.homeModel!.data!.newProducts!.length > 6
              ? 6
              : cubit.homeModel!.data!.newProducts!.length,
          itemBuilder: (context, index) => ProductItem(
              isGrid: false,
              product: cubit.homeModel!.data!.newProducts![index]),
        ),
      ),
    );
  }
}
