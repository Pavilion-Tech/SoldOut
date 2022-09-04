import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/components/constants.dart';


class MyContainer extends StatelessWidget {

  MyContainer(
  this.widget,{
    this.start, this.end, this.noSize  = false,
  });


  Widget? widget;
  double? start;
  double? end;
  bool noSize;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: size!.height*.125,
          bottom: size!.height*.125
      ),
      child: Container(
        decoration:  BoxDecoration(
          color: HexColor('#FBFBFB'),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(20),
            topEnd: Radius.circular(20)
          ),
        ),
        padding: EdgeInsetsDirectional.only(
            top: size!.height*.05,
          start:start??size!.width*.05 ,
          end:end??size!.width*.05
        ),
        height:noSize ? null: size!.height*.9,
        width: double.infinity,
        child: widget,
      ),
    );
  }

}
