import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/models/buyer_model/cart_model/get_cart_model.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_states.dart';
import 'package:soldout/modules/widgets/image_net.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../../../shared/components/constants.dart';

class CartItem extends StatelessWidget {
  CartItem({Key? key, required this.model}) : super(key: key);

  GetCartData model;

  late int currentQnt;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        currentQnt = model.qty!;
        if(model.priceChanged!)
        {
          showToast(msg: '${tr('price_changed')} (${model.name})');
        }
        return Stack(
          children: [
            Slidable(
              direction: Axis.horizontal,
              endActionPane: ActionPane(
                extentRatio: 0.35,
                motion: InkWell(
                  onTap: ()=> cubit.removeFromCart(model.productId!),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                          bottomEnd: Radius.circular(10)),
                      color: HexColor('#FF0000'),
                    ),
                    child: const Icon(
                      Icons.delete_forever,
                      color: defaultColorTwo,
                      size: 50,
                    ),
                  ),
                ),
                children: const[],
              ),
              child: Container(
                height: size!.height>670? size!.height*.1:size!.height*.15,
                width: double.infinity,
                padding: const EdgeInsetsDirectional.all(5),
                decoration: BoxDecoration(
                  color: defaultColorTwo,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: size!.height * .15,
                      width: size!.width * .3,
                      child: ImageNet(image: model.firstImage??'',),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Text(
                              '${model.piecePrice} ${tr('sar')}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //const Spacer(),
                    if (model.stockChanged!)
                      Text(
                        tr('out_of_stock'),
                        style: const TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough),
                      ),
                    if (!model.stockChanged!)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              if(currentQnt == 1)
                              {
                                cubit.removeFromCart(model.productId!);
                              }
                              else
                              {
                                currentQnt--;
                                cubit.addToCart(
                                  productId: model.productId!,
                                  qty: currentQnt,
                                );
                              }

                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: HexColor('#A0AEC0'),
                              child: const Icon(
                                Icons.remove_outlined,
                                color: defaultColorTwo,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$currentQnt',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if(currentQnt != model.stock!)
                              {
                                currentQnt++;
                                cubit.addToCart(
                                  productId: model.productId!,
                                  qty:currentQnt,
                                );
                              }
                              else
                              {
                                showToast(msg: tr('out_of_stock'));
                              }

                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: HexColor('#A0AEC0'),
                              child: const Icon(
                                Icons.add_outlined,
                                color: defaultColorTwo,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            if (model.stockChanged!)
              Slidable(
                direction: Axis.horizontal,
                endActionPane: ActionPane(
                  extentRatio: 0.35,
                  motion: InkWell(
                    onTap: ()=> cubit.removeFromCart(model.productId!),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadiusDirectional.only(
                            topEnd: Radius.circular(10),
                            bottomEnd: Radius.circular(10)),
                        color: HexColor('#FF0000'),
                      ),
                      child: const Icon(
                        Icons.delete_forever,
                        color: defaultColorTwo,
                        size: 50,
                      ),
                    ),
                  ),
                  children: const[],
                ),
                child: Container(
                  height: size!.height * .1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Colors.grey.withOpacity(.5),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

}


