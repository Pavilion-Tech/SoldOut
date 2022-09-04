import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/styles/colors.dart';

class CartLoading extends StatelessWidget {
  const CartLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: 30,
            width: size!.width*.7,
            color: Colors.grey.shade300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        ListView.separated(
          separatorBuilder: (context,index)=>const SizedBox(height: 15,),
          itemCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index)=> Container(
            height: size!.height*.1,
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(5),
            decoration: BoxDecoration(
              color: defaultColorTwo,
              borderRadius: BorderRadiusDirectional.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    height: size!.height*.15,
                    width: size!.width*.3,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 10,
                          width: 100,
                          color: Colors.grey.shade300
                        ),
                      ),
                      Spacer(),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                            height: 10,
                            width: 35,
                            color: Colors.grey.shade300
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20,
                          width: 10,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Align(
          alignment: AlignmentDirectional.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: size!.height * .06,
              width: size!.width * .44,
              color: Colors.grey.shade300,
            ),
          ),
        )
      ],
    );
  }
}
