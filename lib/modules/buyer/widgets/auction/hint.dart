import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import 'custom_paint.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Positioned(
          top: myLocale == 'ar' ? size!.height * .82 : size!.height >670 ?size!.height * .775:size!.height * .65,
          left: myLocale == 'ar' ? size!.width * .05 : size!.width * .34,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: size!.width * .6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: defaultColor,
                ),
                padding: const EdgeInsetsDirectional.only(
                    top: 10,
                    start: 10,
                    end: 5,
                    bottom: 5
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          tr('press+'),
                          style:  TextStyle(
                              color: defaultColorTwo,
                              fontSize: size!.height>670?10:7),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            AuctionCubit.get(context).changeAuctionHint();
                          },
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: defaultColorTwo,
                            child: Text('x', style: TextStyle(height: 01,
                                fontWeight: FontWeight.w900,
                                color: defaultColor),),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      tr('will_deducted'),
                      style: const TextStyle(
                          color: defaultColorTwo,
                          fontSize: 10),
                    ),
                    Text(
                      tr('points_refunded'),
                      style: const TextStyle(
                          color: defaultColorTwo,
                          fontSize: 10,
                          fontWeight: FontWeight.w900
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 15),
                child: Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: MCustomPaint()),
              )
            ],
          ),
        );
      },
    );
  }
}
