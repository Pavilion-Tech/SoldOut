import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/modules/buyer/screens/store_name/store_name_screen.dart';
import 'package:soldout/modules/buyer/widgets/prodect/product_review.dart';
import 'package:soldout/shared/images/images.dart';

import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({this.product});
  ProductModel? product;



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
              SizedBox(height: size!.height * .03,),
              detailsItem(
                 Text(
                   product!.desc!,
                   maxLines: 5,
                   overflow: TextOverflow.ellipsis,
                   style:const TextStyle(height: 1.9),
                ),
              ),
              SizedBox(height: size!.height * .03,),
              ProductReview(product!.reviews!),
              SizedBox(height: size!.height*.02,),
              Align(
                alignment: AlignmentDirectional.center,
                child: defaultButton(
                    onTap: (){
                      if(product!.stock! != 0)
                      {
                        CartCubit.get(context).addToCart(
                          productId: product!.id!,
                          qty:1,
                          context: context
                        );
                      }
                      else
                      {
                        showToast(msg: tr('out_of_stock'));
                      }
                    },
                    text: tr('add_to_cart')
                ),
              ),
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

  Widget productDetails(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           product!.name!,
          maxLines: 1,
          style:const TextStyle(height: 2,fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: size!.height*.02,
        ),
        Row(
          children: [
            Text(
              '${product!.salePrice??product!.regularPrice} ${tr('sar')}',
              style:const TextStyle(fontWeight: FontWeight.bold),
            ),
            if(product!.salePrice !=null)
              Text(
                 '${product!.regularPrice} ${tr('sar')}',
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
                  initialRating: product!.rate!.toDouble(),
                  itemSize: 13,
                  direction: Axis.horizontal,
                  ignoreGestures: true,
                  itemCount: 5,
                  allowHalfRating: true,
                  unratedColor: HexColor('#FFE000'),
                  itemPadding:
                  const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, index) {
                    if (product!.rate! > index) {
                      return Image.asset(BuyerImages.fullStar);
                    } else {
                      return const Icon(Icons.star_border, size: 16,);
                    }
                  },
                  onRatingUpdate: (rating) {},
                  ),
                  Text(
                    '(${product!.numUsersRate!})',
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade400),
                  ),
                ],
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade200,
          ),
        ),
        InkWell(
          onTap: (){
            BuyerCubit.get(context).currentStorePage = 1;
            BuyerCubit.get(context).getListProductsForStore(
                id:  product!.store!.id!,
                text: ''
            );
            navigateTo(context,StoreNameScreen(
              id: product!.store!.id!,
              title: product!.store!.name,
            )
            );
            },
          child:  Text(
            product!.store!.name!,
            maxLines: 1,
            style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
