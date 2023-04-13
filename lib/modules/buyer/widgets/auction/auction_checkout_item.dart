import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/image_net.dart';

import '../../../../shared/components/constants.dart';

class AuctionCheckOutItem extends StatelessWidget {

  AuctionCheckOutItem(this.productName,this.auctionName,this.firstImage);


  String productName;
  String auctionName;
  String firstImage;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:size!.height > 670?size!.height*.09:size!.height*.12,
      child: Row(
        children: [
          SizedBox(
              height: size!.height*.07, width: size!.width*.25,
              child: ImageNet(image: firstImage,)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  productName,
                  style:const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  auctionName,
                  style:const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
