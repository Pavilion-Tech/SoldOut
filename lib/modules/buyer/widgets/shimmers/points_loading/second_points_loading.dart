import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../shared/components/constants.dart';

class SecondPointsLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      child: Container(
        height: size!.height*.2,
        width: size!.width*.75,
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color: Colors.grey.shade300)
        ),
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child:CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,)
            ),
            const SizedBox(height: 30,),
            Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child:Container(
                  height: 30,
                  width: size!.width*.5,
                  color: Colors.grey.shade300,)
            ),
          ],
        ),
      ),
    );
  }
}
