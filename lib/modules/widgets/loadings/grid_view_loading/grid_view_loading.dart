import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/styles/colors.dart';
import '../../my_container.dart';

class GridViewLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MyContainer(
        Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: size!.height*.06,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadiusDirectional.circular(15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 15),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),
              childAspectRatio: size!.width / (size!.height / 2.1),
              mainAxisSpacing: 16,
              crossAxisSpacing: 5,
              crossAxisCount: 2,
              children: List.generate( 6, (index) => buildLoadingItem,),
            ),
          ],
        ),
    );
  }


  Widget buildLoadingItem =  Container(
    height: size!.height * .15,
    width: size!.width * .5,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
        color: defaultColorTwo,
        borderRadius: BorderRadiusDirectional.circular(14),
        border: Border.all(
            color: Colors.grey.shade200
        )
    ),
    child: Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: size!.height * .11,
            width: size!.width * .5,
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
                            width: 50,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Container(
                            height: 10,
                            width: 50,
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
}
