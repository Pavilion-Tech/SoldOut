import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/styles/colors.dart';

class VHomeLoading extends StatelessWidget {
  const VHomeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 30,
                width: size!.width*.4,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Container(
                        height: size!.height*.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: defaultColorTwo,
                          borderRadius: BorderRadiusDirectional.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: size!.height*.06,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: defaultColorTwo,
                        borderRadius: BorderRadiusDirectional.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context,index){
                return Container(
                  height: size!.height*.12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    color: defaultColorTwo,
                  ),
                  padding: const EdgeInsetsDirectional.all(20),
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20,
                          width: size!.width*.2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.white,
                            child: Container(
                              height: 30,
                              width: size!.width*.3,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          const Spacer(),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.white,
                            child:const CircleAvatar(
                              radius: 11,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index)=>const SizedBox(height: 20,),
              itemCount: 3,
          ),
        ),
      ],
    );
  }
}
