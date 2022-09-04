import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';

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
            onTap: () {
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
          if(isProduct)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 25),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
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
                  const SizedBox(
                    width: 15,
                  ),
                  BlocConsumer<BuyerCubit, BuyerStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var cubit = BuyerCubit.get(context);
                      return InkWell(
                        onTap: () {
                          cubit.updateFav(id!);
                        },
                        child: CircleAvatar(
                          backgroundColor: defaultColorTwo,
                          radius: 17,
                          child: Icon(
                            cubit.favorites[id!]!
                                ?Icons.favorite
                                :Icons.favorite_outline_sharp,
                            size: 17,
                            color:cubit.favorites[id!]!
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
          if(!isProduct)
            SizedBox(
              height: 45,
              width: 45,
              child: ClipPolygon(
                sides: 4,
                borderRadius: 15,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    color: defaultColor,
                    child: const Icon(
                      Icons.add, color: defaultColorTwo, size: 16,)),
              ),
            )
        ],
      ),
    );
  }
}
