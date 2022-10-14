import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/buyer_model/cart_model/get_checkout_model.dart';
import '../../../../shared/components/constants.dart';

class StoreCheckOutItem extends StatelessWidget {

  StoreCheckOutItem({this.cart});
  Carts? cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${cart!.storeName} ( ${cart!.countProducts} ${tr('item')} )',
          style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              border: Border.all(
                  color: Colors.grey.shade400.withOpacity(.5)
              )
          ),
          padding: const EdgeInsetsDirectional.all(5),
          child: ListView.separated(
            itemBuilder: (context,index)=>
                listItem(context,cart!.products![index]),
            separatorBuilder: (context,index)=>separatorBuilder,
            itemCount: cart!.products!.length,
            shrinkWrap: true,
            physics:const  NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget listItem (context,Products product){
    return SizedBox(
      height:size!.height>600? size!.height*.09:size!.height*.12,
      child: Row(
        children: [
          SizedBox(
              height: size!.height*.07, width: size!.width*.25,
              child: Image.network(product.firstImage!,)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  product.name!,
                  style:const TextStyle(fontWeight: FontWeight.bold),),
                const Spacer(),
                Text(
                  '(${product.qty} x ${product.piecePrice}) ${tr('sar')}',
                  style:const TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget separatorBuilder = Padding(
      padding: const EdgeInsetsDirectional.all(5),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey.shade200,
      ),
    );
}
