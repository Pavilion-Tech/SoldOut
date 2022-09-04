import 'package:flutter/material.dart';

import '../../../../shared/components/constants.dart';
import 'auction_item.dart';

class ListAuctions extends StatelessWidget {
  const ListAuctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index)=>
          AuctionItem(title: 'Auction Item',state: 'New',time: '10',isHome: true),
      separatorBuilder: (context,index)=>SizedBox(width: size!.width * .025,),
      itemCount: 5,
    );
  }


}
