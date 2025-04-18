import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/components/constants.dart';

class PointsLoading extends StatelessWidget {
  PointsLoading({this.fromAuction = false});
  bool fromAuction ;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Container(
        height:size!.height > 670?size!.height*.13:size!.height*.17,
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color: Colors.grey.shade300)
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 20,
                    width: 100,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10,),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 20,
                    width: fromAuction?size!.width*.35:size!.width*.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
