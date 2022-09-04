import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/modules/buyer/screens/store_name/store_name_screen.dart';
import 'package:soldout/modules/buyer/widgets/prodect/product_review.dart';
import 'package:soldout/shared/images/images.dart';

import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import 'auction_review.dart';

class AuctionDetails extends StatelessWidget {


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
                productDetails(context),
              ),
              SizedBox(
                height: size!.height * .03,
              ),
              detailsItem(
                const Text(
                  'Product Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product Name',
                  maxLines: 5,
                  style: TextStyle(height: 1.9),
                ),
              ),
              SizedBox(
                height: size!.height * .03,
              ),
              AuctionReview(),
              SizedBox(
                height: size!.height*.02,
              ),
              SizedBox(
                height: size!.height*.02,
              ),
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

  Widget productDetails(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Name - Product Name - Product Name - Product Name - Product Name - Product Name',
          maxLines: 2,
          style: TextStyle(height: 2,fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: size!.height*.02,
        ),
        Row(
          children: [
            const  Text(
              '10000 SAR',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 4,
                    itemSize: 13,
                    direction: Axis.horizontal,
                    ignoreGestures: true,
                    itemCount: 5,
                    allowHalfRating: true,
                    unratedColor: HexColor('#FFE000'),
                    itemPadding:
                    const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, index) {
                      if (4 > index) {
                        return Image.asset(BuyerImages.fullStar);
                      } else {
                        return Icon(
                          Icons.star_border,
                          size: 16,
                        );
                      }
                    },
                    onRatingUpdate: (rating) {},
                  ),
                  Text(
                    '(52)',
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade400),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Status | 10:20:30',
                    style: TextStyle(fontWeight: FontWeight.bold,color: defaultColor),
                  )
                ],
              ),
          ],
        ),

      ],
    );
  }
}
