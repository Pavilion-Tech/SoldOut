import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../models/vendor_model/vendor_order_model.dart';
import '../../../../../shared/components/constants.dart';


class VPurchasesProductItem extends StatelessWidget {

  VPurchasesProductItem({required this.product});

  Products product;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size!.height > 670 ?size!.height*.1:size!.height*.12 ,
      child: Row(
        children: [
          SizedBox(
                height: 70, width: size!.width*.25,
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
}
