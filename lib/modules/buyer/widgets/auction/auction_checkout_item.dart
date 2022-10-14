import 'package:flutter/material.dart';

import '../../../../shared/components/constants.dart';

class AuctionCheckOutItem extends StatelessWidget {

  AuctionCheckOutItem(this.productName,this.auctionName,this.firstImage);


  String productName;
  String auctionName;
  String firstImage;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:size!.height > 600?size!.height*.09:size!.height*.12,
      child: Row(
        children: [
          SizedBox(
              height: size!.height*.07, width: size!.width*.25,
              child: Image.network(
                firstImage,
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
