import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class ProductLoading extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: size!.height * .385,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: size!.height * .35,
          ),
          child: Container(
            decoration:const  BoxDecoration(
              color: defaultColorTwo,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20), topEnd: Radius.circular(20)),
            ),
            padding: EdgeInsetsDirectional.only(
              top: size!.height * .040,
              start: size!.width * .05,
              end: size!.width * .05,
            ),
            height: size!.height * .65,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  detailsItem(
                    productDetails(context),
                  ),
                  SizedBox(
                    height: size!.height * .03,
                  ),
                  detailsItem(
                    ListView.separated(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (c,i){
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Container(
                            height: 20,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                        );
                      },
                      separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                      itemCount: 5,
                    ),
                  ),
                  SizedBox(
                    height: size!.height * .03,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: defaultColorTwo,
                        borderRadius: const BorderRadiusDirectional.only(
                            topEnd: Radius.circular(10), topStart: Radius.circular(10)),
                        border: Border.all(
                          color: Colors.blue.shade100.withOpacity(.5),
                        )),
                    padding: const EdgeInsetsDirectional.only(
                      top: 15,
                      start: 15,
                      end: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Container(
                            height: 50,
                            width: size!.width*.3,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
                          child: Container(
                            height: 2,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        reviewProductItem(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size!.height*.02,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget detailsItem(Widget widget) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: defaultColorTwo,
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      padding: const EdgeInsetsDirectional.all(10),
      child: widget,
    );
  }

  Widget productDetails(BuildContext context){
    return Column(
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
        SizedBox(
          height: size!.height*.02,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: 20,
            width: size!.width*.7,
            color: Colors.grey.shade300,
          ),
        ),
        SizedBox(
          height: size!.height*.02,
        ),
        Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 30,
                width: 50,
                color: Colors.grey.shade300,
              ),
            ),
            const Spacer(),
            Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: 30,
                  width: 100,
                  color: Colors.grey.shade300,
                ),
              ),
          ],
        ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
          ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: 30,
            width: 70,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget reviewProductItem() {
    return Column(
      children: [
        Row(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 10,
                width: size!.width*.2,
                color: Colors.grey.shade300,
              ),
            ),
            const Spacer(),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 10,
                width: size!.width*.3,
                color: Colors.grey.shade300,
              ),
            )
          ],
        ),
        SizedBox(
          height: size!.height * .02,
        ),
        ListView.separated(
          physics:const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (c,i){
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            );
          },
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          itemCount: 5,
        ),
        SizedBox(
          height: size!.height * .01,
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: 10,
              width: size!.width*.4,
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }
}
