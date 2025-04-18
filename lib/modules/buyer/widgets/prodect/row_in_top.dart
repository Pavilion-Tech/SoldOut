import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/auth/sign_in/sign_in_screen.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/points.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/widgets/auction/points_dialog.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/firebase_helper/dynamic_links.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class RowInTop extends StatelessWidget {
  RowInTop({this.isProduct = true, this.id,this.status});

  bool isProduct;
  int? id;
  String? status;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size!.height * .05,
      width: size!.width,
      child: Row(
        children: [
          InkWell(
            onTap: (){
              if(!isProduct){
                if(status == 'processing')
                {
                  AuctionCubit.get(context).unsubscribePusher(id!);
                }
              }
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
                      String shortLink =
                          'https://www.google.com/?product=$id';
                      Uri link = await DynamicLinksClient.createUri(
                          shortLink.toString());
                      Share.share(link.toString());
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
                            cubit.updateFav(id!,context);
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
          if (!isProduct)
            InkWell(
              onTap: (){
                SettingsCubit.get(context).getAllPoints(context);
                showDialog(
                  context: context,
                  builder: (context)=>PointsDialog(),
                );
              },
              child: Container(
                height: 40,
                width: 70,
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsetsDirectional.only(end: 5),
                decoration: const BoxDecoration(
                  color: defaultColorTwo,
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      bottomStart: Radius.circular(20)),
                ),
                child: Text(
                  'points'.tr()
                ),
              ),
            )
        ],
      ),
    );
  }
}
