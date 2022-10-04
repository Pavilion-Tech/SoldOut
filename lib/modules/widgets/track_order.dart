import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/styles/colors.dart';

class TrackOrder extends StatelessWidget {
  TrackOrder({required this.status});

  String status;



  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      [
        Row(
          children: [
            const Spacer(),
            orderStatus(
              title: tr('processing2'),
              isSelected: status == 'processing'
                  || status == 'shipped'
                  || status == 'completed',
            ),
            const Spacer(),
            orderStatus(
              title: tr('completed'),
              isSelected:status == 'completed',

            ),
          ],
        ),
        SizedBox(
          width: size!.width*.7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 3,
                  width: size!.width*.7,
                  color: defaultColor,
                ),
                Row(
                  children: [
                    circel(isSelected: status == 'new'
                        || status == 'processing'
                        || status == 'shipped'
                        || status == 'completed',),
                    const Spacer(),
                    circel( isSelected: status == 'processing'
                        || status == 'shipped'
                        || status == 'completed',),
                    const Spacer(),
                    circel(isSelected: status == 'shipped' || status == 'completed'),
                    const Spacer(),
                    circel(isSelected:status == 'completed'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            orderStatus(
              title: tr('new_order'),
              isSelected: status == 'new'
                  || status == 'processing'
                  || status == 'shipped'
                  || status == 'completed',
            ),
            const Spacer(),
            orderStatus(
              title: tr('shipped'),
              isSelected: status == 'shipped' || status == 'completed',
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget orderStatus({
    required bool isSelected,
    required String title,

  })
  {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          gradient:isSelected ?const LinearGradient(
            colors: [Colors.blue,Colors.green],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ):null,
        borderRadius: BorderRadiusDirectional.circular(5),
        border: Border.all(color:defaultColor)
      ),
      child: Text(
        title,
        style: TextStyle(
          color:isSelected?defaultColorTwo:defaultColor,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget circel({
    required bool isSelected,
})
  {
    return CircleAvatar(
      radius: 10,
      backgroundColor: defaultColor,
      child: CircleAvatar(
        radius: 8,
        backgroundColor:isSelected?defaultColor:Colors.white,
      ),
    );
  }
}
