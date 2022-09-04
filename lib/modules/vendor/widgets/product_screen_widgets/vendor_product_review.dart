import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';

class VProductReview extends StatelessWidget {

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
            'Product Review',
            style: TextStyle(
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
            itemBuilder: (context, index) =>reviewProductItem(),
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
            physics: NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }

  Widget reviewProductItem() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'User Name',
              maxLines: 1,
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            RatingBar.builder(
              initialRating: 4,
              itemSize: 13,
              direction: Axis.horizontal,
              ignoreGestures: true,
              itemCount: 5,
              allowHalfRating: true,
              unratedColor: HexColor('#FFE000'),
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, index) {
                if (4 > index) {
                  return Image.asset(BuyerImages.fullStar);
                } else {
                  return Image.asset(BuyerImages.noStar);
                }
              },
              onRatingUpdate: (rating) {},
            ),
          ],
        ),
        SizedBox(
          height: size!.height * .02,
        ),
        Text(
          'Product Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product NameProduct Name - Product Name - Product Name - Product Name - Product Name - Product Name',
          maxLines: 5,
          style: TextStyle(height: 1.9),
        ),
        SizedBox(
          height: size!.height * .01,
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            '19, May, 2022 , 12:00 AM',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ),
      ],
    );
  }

}
