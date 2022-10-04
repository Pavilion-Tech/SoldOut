import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/buyer_model/order_model.dart';
import 'package:soldout/modules/widgets/track_order.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../../../../shared/components/constants.dart';
import '../../../../screens/settings/setting_screens/my_account/order/rate_review.dart';

class StoreOrderItem extends StatelessWidget {

  StoreOrderItem({required this.stores});

  Stores stores;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${stores.name} ( ${stores.countProducts} ${tr('item')} )',
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
          child: Column(
            children: [
              if(stores.status == 'rejected')
              orderReject(),
              if(stores.status != 'rejected')
              TrackOrder(status: stores.status!),
              const SizedBox(height: 20,),
              ListView.separated(
                itemBuilder: (context,index)=> listItem(
                  context:context,
                  product: stores.products![index]
                ),
                separatorBuilder: (context,index)=>separatorBuilder(),
                itemCount: stores.products!.length,
                shrinkWrap: true,
                physics:const  NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget listItem ({
  required BuildContext context,
  required Products product,
}){
    return SizedBox(
      height:size!.height*.13,
      child: Row(
        children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SizedBox(
                    height: size!.height*.12, width: size!.width*.25,
                    child: Image.network(
                      product.firstImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (c,o,s)=>const Icon(Icons.info),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                ),
                InkWell(
                  onTap: (){
                    navigateTo(context, RateAndReview(id:product.id!));
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    height: size!.height*.02, width: size!.width*.25,
                    color: Colors.blue.shade100,
                    child:  Text(
                      tr('rate_review'),
                      style:const TextStyle(
                          color: defaultColor,
                          height:1.5,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  product.name!,
                  style:const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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

  Widget separatorBuilder ()=> Padding(
    padding: const EdgeInsetsDirectional.all(5),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade200,
    ),
  );

  Widget orderReject()
  {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(5),
        color: Colors.red
      ),
      child: Text(
        tr('rejected'),
        style:const TextStyle(
            color:defaultColorTwo,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
