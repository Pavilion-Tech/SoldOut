import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/buyer_model/home_model/new_auctions_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../shared/styles/colors.dart';

class UserBids extends StatelessWidget {

  UserBids(this.bids);

  List<Bids> bids;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: defaultColorTwo,
          borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(10), topStart: Radius.circular(10)),
          border: Border.all(
            color: Colors.blue.shade100.withOpacity(.5),
          )),
      padding: const EdgeInsetsDirectional.only(
        top: 15,
        start: 15,
        end: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
           tr('user_bids'),
            style:const TextStyle(
                color: defaultColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          Container(
            height: 2,
            width: double.infinity,
            color: Colors.blue,
          ),
          if(bids.isNotEmpty)
            ListView.separated(
            itemBuilder: (context, index) =>reviewAuctionItem(bids[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade400,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: bids.length,
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
          ),
          if(bids.isEmpty)
            Text(tr('no_bids')),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }


  Widget reviewAuctionItem(Bids bids) {
   //final time =DateTime.fromMillisecondsSinceEpoch(bids.createdAt!);
   var time = DateTime.fromMillisecondsSinceEpoch(bids.createdAt! * 1000);
   print(bids.createdAt);
   String ago = timeago.format(time, locale: 'en_short');
   print(ago);
   return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            bids.userName??'',
            maxLines: 1,
            style:const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 1,
              height: 10,
              color: Colors.black,
            ),
          ),
          Text('${bids.bidAmount} ${tr('sar')}',
            style:const TextStyle(
                color: defaultColor,
                fontSize: 12
            ),),
          const Spacer(),
          Text('$ago ago',style:const TextStyle(color: Colors.grey,fontSize: 12),),
        ],
      ),
    );
  }
}
