import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/auth/sign_in/sign_in_screen.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/firebase_helper/dynamic_links.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class RowInTop extends StatelessWidget {
  RowInTop({this.isProduct = true, this.id});

  bool isProduct;
  int? id;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size!.height * .05,
      width: size!.width,
      child: Row(
        children: [
          InkWell(
            onTap: (){
              if(!isProduct)AuctionCubit.get(context).unsubscribePusher(id!);
              BuyerCubit.get(context).getHomeData(context);
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 70,
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsetsDirectional.only(end: 5),
              decoration: const BoxDecoration(
                color: defaultColorTwo,
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20),
                    bottomEnd: Radius.circular(20)),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 35,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          if (isProduct)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 25),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      String uri = 'https://soldoutapp/?product=$id';
                      Uri sharableLink = await DynamicLinksClient.createUri(uri);
                      Share.share(sharableLink.toString());
                    },
                    child: const CircleAvatar(
                      backgroundColor: defaultColorTwo,
                      radius: 17,
                      child: Icon(
                        Icons.share,
                        size: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  BlocConsumer<BuyerCubit, BuyerStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var cubit = BuyerCubit.get(context);
                      return InkWell(
                        onTap: () {
                          if (token != null) {
                            cubit.updateFav(id!);
                          } else {
                            navigateTo(context, SignInScreen());
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: defaultColorTwo,
                          radius: 17,
                          child: Icon(
                            cubit.favorites[id!]!
                                ? Icons.favorite
                                : Icons.favorite_outline_sharp,
                            size: 17,
                            color: cubit.favorites[id!]!
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
