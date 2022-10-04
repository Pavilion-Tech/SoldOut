import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/widgets/auction/count_down.dart';
import '../../../../models/buyer_model/home_model/new_auctions_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import 'auction_review.dart';

class AuctionDetails extends StatelessWidget {
  AuctionDetails(this.model,this.duration);


  AuctionModel model;
  Duration duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: size!.height * .35,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(20), topEnd: Radius.circular(20)),
        ),
        padding: EdgeInsetsDirectional.only(
          top: size!.height * .040,
          start: size!.width * .05,
          end: size!.width * .05,
        ),
        height: size!.height * .65,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              detailsItem(
                productDetails(),
              ),
              SizedBox(height: size!.height * .03,),
              detailsItem(
                 Text(
                   model.productDesc!,
                  maxLines: 5,
                  style:const TextStyle(height: 1.9),
                ),
              ),
              SizedBox(height: size!.height * .03,),
              UserBids(model.bids!),
              SizedBox(height: size!.height*.02,),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailsItem(Widget widget) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: defaultColorTwo,
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(
            color: Colors.blue.shade100.withOpacity(.5),
          )),
      padding: const EdgeInsetsDirectional.all(10),
      child: widget,
    );
  }

  Widget productDetails(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.productName!,
          maxLines: 2,
          style:const TextStyle(height: 2,fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: size!.height*.02,
        ),
        Row(
          children: [
            Text(
              '${model.auctionOpeningPrice!} ${tr('sar')}',
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              '${tr('${model.status!}')} | ',
              style:const TextStyle(
              color: defaultColor,fontSize: 14,fontWeight: FontWeight.bold),
            ),
            if(model.status == 'processing')
              CountDown(fontSize: 14,duration: duration),
          ],
        ),

      ],
    );
  }
}
