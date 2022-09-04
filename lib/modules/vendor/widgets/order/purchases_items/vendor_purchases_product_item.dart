import 'package:flutter/material.dart';

import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';


class VPurchasesProductItem extends StatelessWidget {
  const VPurchasesProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size!.height*.1 ,
      child: Row(
        children: [
          Container(
                height: size!.height*.07, width: size!.width*.25,
                child: Image.asset(BuyerImages.logo,fit: BoxFit.cover,)
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:const  [
                Text('Product Name - Product Name',style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer(),
                Text('2 x 10 Sar',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
