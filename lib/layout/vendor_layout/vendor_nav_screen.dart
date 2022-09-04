import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:soldout/shared/styles/colors.dart';
import 'cubit/vendor_cubit.dart';

class VendorNavBar extends StatelessWidget {
  final List<Map<String, Widget>> items;
  VendorNavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = VendorCubit.get(context);
    return Container(
      height: 90,
      color: defaultColorTwo,
      // padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((e) {
          return GestureDetector(
            onTap: () => cubit.changeIndex(items.indexOf(e)),
            child: Container(
                child: cubit.currentIndex == (items.indexOf(e))
                    ? ClipPolygon(
                        sides: 4,
                        borderRadius: 25,
                        child: Container(
                            padding: const EdgeInsets.all(15),
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
