import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/widgets/order/purchases_items/vendor_purchases_product_item.dart';


class VListStoreItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Items (2)',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
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
            itemBuilder: (context,index)=>VPurchasesProductItem(),
            separatorBuilder: (context,index)=>separatorBuilder,
            itemCount: 2,
            shrinkWrap: true,
            physics:const  NeverScrollableScrollPhysics(),
          ),
        ),
      ],
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
