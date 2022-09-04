import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/modules/buyer/screens/product/product_screen.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';

import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class ProductItem extends StatelessWidget {


  ProductItem({
    this.isGrid = true,
    this.product
  });

  bool isGrid;
  ProductModel? product;


@override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, ProductScreen(product: product!,));
      },
      child: Container(
        height: size!.height*.15,
        width: isGrid? size!.width * .5 :size!.width*.35,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: defaultColorTwo,
          borderRadius: BorderRadiusDirectional.circular(14),
          border: Border.all(
            color: Colors.blue.shade100.withOpacity(.5)
          )
        ),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: isGrid ? size!.height * .11 :size!.height*.1,
                    width: isGrid ?  size!.width * .5: size!.width*.36,
                    child: Image.network(
                      product!.images![0].image!,
                      fit: BoxFit.cover,)
                ),
                BlocConsumer<BuyerCubit, BuyerStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = BuyerCubit.get(context);
                    return Positioned(
                        top: -size!.height * .010,
                        right: -size!.width * .03  ,
                        left: isGrid ? size!.width * .35 : size!.width * .25,
                        child: IconButton(
                            onPressed: (){
                              cubit.updateFav(product!.id!);
                            },
                            icon: Icon(
                              cubit.favorites[product!.id]!
                                  ?  Icons.favorite
                                  : Icons.favorite_border_sharp,
                              color:cubit.favorites[product!.id]!
                                  ? Colors.red
                                  : defaultColor,
                              size: 18,
                            )
                        )
                    );
                    },
                )
              ],
            ),
            SizedBox(height: size!.height*.009,),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product!.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: size!.height*.05,
                        width: size!.width*.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: product!.rate!.toDouble(),
                              itemSize: 10,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              itemCount: 5,
                              allowHalfRating: true,
                              unratedColor: HexColor('#FFE000'),
                              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, index)  {
                                if(product!.rate! > index){
                                  return Image.asset(BuyerImages.fullStar);
                                }else{
                                  return const Icon(
                                    Icons.star_border,
                                    size: 16,
                                  );
                                }
                                },
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                              '${product!.regularPrice!} ${tr('sar')}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:const TextStyle(color: defaultColor,fontSize: 11,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                         if(product!.stock != 0){
                           CartCubit.get(context).addToCart(
                             productId:product!.id!,
                             qty: 1,
                           );
                         }else{
                           showToast(msg:tr('out_of_stock'));
                         }
                        },
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: Image.asset(BuyerImages.cart),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
