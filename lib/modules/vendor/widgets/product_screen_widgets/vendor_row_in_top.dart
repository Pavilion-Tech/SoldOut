import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class VRowInTop extends StatelessWidget {


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
        ],
      ),
    );
  }
}
