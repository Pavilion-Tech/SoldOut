import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../models/buyer_model/product_model/review_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';

class ProductReview extends StatelessWidget {
  ProductReview(this.reviews);

  List<Reviews> reviews;



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
            tr('product_review'),
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
          if(reviews.isNotEmpty)
            ListView.separated(
            itemBuilder: (context, index) =>reviewProductItem(reviews[index]) ,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.shade400,
              ),
            ),
            itemCount: reviews.length,
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
          ),
          if(reviews.isEmpty)
            Text(tr('no_review')),
            const SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget reviewProductItem(Reviews reviews) {
    String time =DateFormat('',myLocale == 'ar'?'ar':'en')
        .add_yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(Duration(seconds: reviews.createdAt!).inMilliseconds));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
             Text(
               reviews.userName!,
              maxLines: 1,
              style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            RatingBar.builder(
              initialRating: reviews.rate!.toDouble(),
              itemSize: 13,
              direction: Axis.horizontal,
              ignoreGestures: true,
              itemCount: 5,
              allowHalfRating: true,
              unratedColor: HexColor('#FFE000'),
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, index) {
                if (reviews.rate! > index) {
                  return Image.asset(BuyerImages.fullStar);
                } else {
                  return const Icon(Icons.star_border, size: 16,);
                }
              },
              onRatingUpdate: (rating) {},
            ),
          ],
        ),
        SizedBox(height: size!.height * .02,),
        Text(
          reviews.review!,
          maxLines: 5,
          style:const TextStyle(height: 1.9),
        ),
        SizedBox(
          height: size!.height * .01,
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ),
      ],
    );
  }

}
