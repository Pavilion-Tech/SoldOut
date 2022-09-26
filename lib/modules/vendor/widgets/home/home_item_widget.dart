import 'package:flutter/material.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../../shared/components/constants.dart';

class HomeItemWidget extends StatelessWidget {


  HomeItemWidget({
    required this.title,
    required this.count,
    required this.circleColor,
});

  Color circleColor;
  String title;
  String count;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height*.12,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        color: defaultColorTwo,
      ),
      padding: const EdgeInsetsDirectional.all(20),
      alignment: AlignmentDirectional.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade500,),
          ),
          Row(
            children: [
              Text(
                count,
                style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 20),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 11,
                backgroundColor: circleColor,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: defaultColorTwo,
                  child: CircleAvatar(
                    radius: 5.5,
                    backgroundColor: circleColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
