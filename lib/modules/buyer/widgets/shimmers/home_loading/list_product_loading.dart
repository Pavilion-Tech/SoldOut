import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/components/constants.dart';
import '../../../../../shared/styles/colors.dart';

class ListProductsLoading extends StatelessWidget {
  const ListProductsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context,index)=>SizedBox(width: size!.width * .020,),
      itemCount: 5,
      itemBuilder: (context,index){
        return Container(
          height: size!.height*.15,
          width: size!.width*.35,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              color: defaultColorTwo,
              borderRadius: BorderRadiusDirectional.circular(14),
          ),
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: size!.height*.1,
                  width: size!.width*.36,
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(height: size!.height*.009,),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 20,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: size!.height*.05,
                          width: size!.width*.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.white,
                                child: Container(
                                  height: 10,
                                  width: 100,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.white,
                                child: Container(
                                  height: 10,
                                  width: 100,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: size!.height * .05,
                          width: size!.width * .11,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.white,
                            child: ClipPolygon(
                              sides: 4,
                              borderRadius: 15,
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  color: defaultColor,
                                  ),
                            ),
                          ),
                        )
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
