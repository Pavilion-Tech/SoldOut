import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:soldout/shared/styles/colors.dart';
import 'cubit/buyer_cubit.dart';

class NavBar extends StatelessWidget {
  final List<Map<String, Widget>> items;
  NavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BuyerCubit.get(context);
    return Container(
      height: 90,
      color:cubit.currentIndex == 0?Colors.transparent:Colors.white,
      // padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((e) {
          return GestureDetector(
            onTap: () => cubit.changeIndex(items.indexOf(e),context: context),
            child: Container(
                child: cubit.currentIndex == (items.indexOf(e))
                    ? ClipPolygon(
                  sides: 4,
                  borderRadius: 25,
                  child: Container(
                      padding: const EdgeInsets.all(30),
                      color: defaultColor,
                      child: e['activeIcon']),
                )
                    : e['icon']!),
          );
        }).toList(),
      ),
    );
  }
}
