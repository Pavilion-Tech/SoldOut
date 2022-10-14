import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../screens/auction/auction_cubit/auction_cubit.dart';
import '../../screens/auction/auction_cubit/auction_states.dart';

class JoinAuction extends StatelessWidget {

  JoinAuction({required this.id,required this.coins,required this.state});

  int id;
  int coins;
  AuctionStates state;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child:state is! AuctionLoading ?  InkWell(
        onTap: () {
          AuctionCubit.get(context).joinAuctions(id, context);
        },
        child: Container(
          height: size!.height >600 ?size!.height * .06:size!.height * .08,
          width: size!.height >600 ?size!.width * .7:size!.width * .8,
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${tr('join_auction')} $coins ${tr('coins')}',
                style:const TextStyle(
                    color: defaultColorTwo,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              Image.asset(BuyerImages.points, height: 30, width: 30,)
            ],
          ),
        ),
      ): const CircularProgressIndicator(),
    );
  }
}
