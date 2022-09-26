import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/modules/vendor/widgets/product_screen_widgets/vendor_product_review.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class VProductDetails extends StatelessWidget {

  VProductDetails({
    required this.productModel,
  });

  ProductModel productModel;

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
                 Text(
                   productModel.desc!,
                   maxLines: 5,
                   style:const TextStyle(height: 1.9),
                 ),
              ),
              SizedBox(height: size!.height * .03,),
              VProductReview(reviews: productModel.reviews!),
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
         Text(
           productModel.name!,
           maxLines: 2,
           overflow: TextOverflow.ellipsis,
           style:const TextStyle(
              height: 2,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: size!.height*.02,),
        Row(
          children: [
            Text(
              '${productModel.regularPrice} ${tr('sar')}',
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5,),
            if(productModel.salePrice!=null)
              Text(
                 '${productModel.salePrice} ${tr('sar')}',
                style:const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough
                ),
              ),
            const Spacer(),
              Row(
                children: [
                  RatingBar.builder(
                  initialRating: productModel.rate!.toDouble(),
                  itemSize: 13,
                  direction: Axis.horizontal,
                  ignoreGestures: true,
                  itemCount: 5,
                  allowHalfRating: true,
                  unratedColor: HexColor('#FFE000'),
                  itemPadding:
                  const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, index) {
                    if (productModel.rate! > index) {
                      return Image.asset(BuyerImages.fullStar);
                    } else {
                      return Image.asset(BuyerImages.noStar);
                    }
                  },
                  onRatingUpdate: (rating) {},
            ),
                  Text(
                    '(${productModel.numUsersRate})',
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade400),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
