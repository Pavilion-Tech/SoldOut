import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/screens/product/product_screen.dart';
import 'package:soldout/modules/buyer/widgets/items_shared/flying_cart.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../widgets/image_net.dart';
import '../../auth/sign_in/sign_in_screen.dart';
import '../../screens/cart/cart_cubit/cart_cubit.dart';

class ProductItem extends StatelessWidget {
  ProductItem({this.isGrid = true, this.product});

  bool isGrid;
  ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BuyerCubit.get(context);
        return InkWell(
          onTap: () {
            navigateTo(
                context,
                ProductScreen(
                  product: product,
                ));
          },
          child: Container(
            height: size!.height * .15,
            width: isGrid ? size!.width * .5 : size!.width * .35,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                color: defaultColorTwo,
                borderRadius: BorderRadiusDirectional.circular(14),
                border:
                    Border.all(color: Colors.blue.shade100.withOpacity(.5))),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: isGrid ? size!.height * .11 : size!.height * .1,
                        width: isGrid ? size!.width * .5 : size!.width * .36,
                        child: ImageNet(image: product?.images?[0].image??'',)
                    ),
                    Positioned(
                        top: -size!.height * .010,
                        right: -size!.width * .03,
                        left: isGrid ? size!.width * .35 : size!.width * .25,
                        child: IconButton(
                            onPressed: () {
                              if (token != null) {
                                cubit.updateFav(product?.id??0,context);
                              } else {
                                navigateTo(context, SignInScreen());
                              }
                            },
                            icon: Icon(
                              cubit.favorites[product?.id]??false
                                  ? Icons.favorite
                                  : Icons.favorite_border_sharp,
                              color: cubit.favorites[product?.id]??false
                                  ? Colors.red
                                  : defaultColor,
                              size: 18,
                            ))),
                  ],
                ),
                // if(size!.height > 600)
                // SizedBox(height: size!.height * .009,),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product?.name??'',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height:size!.height > 600 ? size!.height * .05:size!.height * .06,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  initialRating: product?.rate?.toDouble(),
                                  itemSize: 15,
                                  direction: Axis.horizontal,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  allowHalfRating: true,
                                  unratedColor: HexColor('#FFE000'),
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal:1.0),
                                  itemBuilder:(context, index) {
                                    if (product?.rate > index) {
                                      return Image.asset(BuyerImages.fullStar);
                                    } else {
                                      return const Icon(Icons.star_border,size:16,);
                                    }
                                  },
                                  onRatingUpdate: (rating) {},
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${product?.salePrice ?? product?.regularPrice}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: defaultColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      tr('sar'),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTapDown: (TapDownDetails details) {
                              // var x = details.globalPosition.dx;
                              // var y = details.globalPosition.dy;
                              if (product?.stock != 0) {
                                CartCubit.get(context).addToCart(
                                  productId: product?.id??0,
                                  qty: 1,
                                  context: context
                                );
                                // cubit.flyingCart = FlyingCart(
                                //   y,x,
                                //   product!.images![0].image!,
                                //   isGrid: isGrid,
                                // );
                                // cubit.emitState();
                                // Future.delayed(Duration(seconds: 4), () {
                                //   cubit.flyingCart = null;
                                //   cubit.emitState();
                                // });
                              } else {
                                showToast(msg: tr('out_of_stock'));
                              }
                            },
                            onTap: null,
                            child: SizedBox(
                              height: size!.width*.109,
                              width: size!.width*.109,
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
      },
    );
  }


}
