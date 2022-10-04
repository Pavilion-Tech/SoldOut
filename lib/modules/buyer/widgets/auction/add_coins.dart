import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';

import '../../../../shared/styles/colors.dart';

class AddCoins extends StatelessWidget {
  AddCoins(this.id);
  int id ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 10,bottom: 10),
        child: InkWell(
          onTap: ()=>AuctionCubit.get(context).bid(id, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                tr('bid'),
                style:const TextStyle(
                    color: defaultColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 22
                ),
              ),
              SizedBox(
                height: 70,
                width: 70,
                child: ClipPolygon(
                  sides: 4,
                  borderRadius: 15,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      color: defaultColor,
                      child: const Icon(
                        Icons.add, color: defaultColorTwo, size: 35,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
