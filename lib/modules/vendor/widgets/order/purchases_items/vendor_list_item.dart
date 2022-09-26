import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/vendor_model/vendor_order_model.dart';
import 'package:soldout/modules/vendor/widgets/order/purchases_items/vendor_purchases_product_item.dart';


class VListStoreItem extends StatelessWidget {

  VListStoreItem({required this.products});

  List<Products> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           '${tr('item')} (${products.length})',
           style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
         ),

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
            itemBuilder: (context,index)=>VPurchasesProductItem(product:products[index]),
            separatorBuilder: (context,index)=>separatorBuilder(),
            itemCount: products.length,
            shrinkWrap: true,
            physics:const  NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget separatorBuilder (){
    return Padding(
      padding: const EdgeInsetsDirectional.all(5),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey.shade200,
      ),
    );
  }
}
