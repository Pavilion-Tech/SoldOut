import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../shared/styles/colors.dart';

class AuctionReview extends StatelessWidget {

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
        children: [
          Text(
           tr('user_bids'),
            style:const TextStyle(
                color: defaultColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
            child: Container(
              height: 2,
              width: double.infinity,
              color: Colors.blue,
            ),
          ),
          ListView.separated(
            itemBuilder: (context, index) =>reviewAuctionItem(),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade400,
              ),
            ),
            itemCount: 5,
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }


  Widget reviewAuctionItem() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            'User Name',
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 1,
              height: 10,
              color: Colors.black,
            ),
          ),
          Text('1700 SAR',style: TextStyle(color: defaultColor),),
          Spacer(),
          Text('1m ago',style: TextStyle(color: Colors.grey,fontSize: 12),),
        ],
      ),
    );
  }
}
