import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';

class CarouselSliderLoading extends StatelessWidget {
  const CarouselSliderLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            decoration:
            BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15),
              color: Colors.grey.shade300
            ),
            height: size!.height * .18,
            width: size!.width * .9,
            child:const SizedBox(),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size!.height * .010),
            child: Row(
              children: [
               customIndicatorOff(),
                const SizedBox(width: 3,),
               customIndicatorOff(),
                const SizedBox(width: 3,),
                customIndicatorOff(),
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget customIndicatorOff() => Image.asset(BuyerImages.indicatorOff,height: 20,width: 20,);

}
