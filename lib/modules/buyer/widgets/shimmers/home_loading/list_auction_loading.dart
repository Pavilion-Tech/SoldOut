import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/components/constants.dart';

class ListAuctionsLoading extends StatelessWidget {
  const ListAuctionsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context,index)=>SizedBox(width: size!.width * .025,),
      itemCount: 5,
      itemBuilder: (context,index){
        return Container(
          height: size!.height*.20,
          width: size!.width*.9,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                    height: size!.height*.12,
                    width: size!.width,
                  color: Colors.grey.shade300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 20,
                        width: 100,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    if(size!.height > 600 )
                    const SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Container(
                            height: 10,
                            width: 50,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        const Spacer(),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Container(
                            height: 10,
                            width: 60,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}
