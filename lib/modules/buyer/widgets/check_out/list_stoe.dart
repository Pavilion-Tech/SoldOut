import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/modules/buyer/widgets/check_out/list_store_item.dart';

class ListStore extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cubit= CartCubit.get(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 20.0,
        start: 20.0,
        end: 20.0
      ),
      child: ListView.separated(
        itemBuilder: (context,index)=>
            ListStoreItem(
                cart:cubit.getCheckOutModel!.data!.carts![index]
            ),
        separatorBuilder: (context,index)=>const SizedBox(height: 20,),
        itemCount: cubit.getCheckOutModel!.data!.carts!.length,
        shrinkWrap: true,
        physics:const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
