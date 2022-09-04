import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/widgets/sort/sort_sheet.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class Suffix extends StatelessWidget {
  Suffix({required this.apply});

  VoidCallback apply;

  Sort? sort;

  @override
  Widget build(BuildContext context) {
    sort = Sort(apply: apply,);
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: size!.height * .03,
          width: 1,
          color: Colors.grey.shade200,
        ),
        SizedBox(
          width: size!.width * .05,
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: defaultColorTwo,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(15),
                    topEnd: Radius.circular(15),
                  )),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              builder: (context) => StatefulBuilder(
                  builder: (context, setStateSB) => sort!
              ),
            );
          },
          child: Icon(
            Icons.filter_alt_outlined,
            size: 30,
            color: Colors.grey.shade400,
          ),
        )
      ],
    );
  }
}
