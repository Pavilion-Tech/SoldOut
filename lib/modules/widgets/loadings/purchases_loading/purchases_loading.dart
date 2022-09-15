import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soldout/modules/buyer/widgets/check_out/invoice.dart';
import 'package:soldout/modules/buyer/widgets/check_out/store_checkout_item.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../../../../shared/components/constants.dart';

class PurchasesDetailsLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size!.height * .14,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(
              color: Colors.grey.shade300.withOpacity(.5),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: 30,
                  width: size!.width*.2,
                  color: Colors.grey.shade300,
                ),
              ),
              Spacer(),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: 10,
                  width: size!.width*.4,
                  color: Colors.grey.shade300,
                ),
              ),
              Spacer(),
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
                  Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 10,
                      width: size!.width*.3,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: ListView.separated(
            itemBuilder: (context, index) => listStoreLoading(),
            separatorBuilder: (context, index) => SizedBox(height: 10,),
            itemCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
        invoiceLoading(),
      ],
    );
  }

  Widget listStoreLoading(){
    return Column(
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
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              border: Border.all(
                  color: Colors.grey.shade400.withOpacity(.5)
              )
          ),
          padding: const EdgeInsetsDirectional.all(5),
          child: ListView.separated(
            itemBuilder: (context,index)=>listItemLoading(),
            separatorBuilder: (context,index)=>separatorBuilder,
            itemCount: 2,
            shrinkWrap: true,
            physics:const  NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  Widget listItemLoading(){
    return SizedBox(
      height:size!.height*.13,
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: size!.height*.07,
              width: size!.width*.25,
              color: Colors.grey.shade300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: 30,
                  width: size!.width*.5,
                  color: Colors.grey.shade300,
                ),
              ),
                Spacer(),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 30,
                    width: size!.width*.1,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget invoiceLoading(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: 30,
            width: size!.width*.2,
            color: Colors.grey.shade300,
          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 18),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: size!.width*.1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: size!.width*.05,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: size!.width*.1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: size!.width*.05,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: size!.width*.1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: size!.width*.05,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget separatorBuilder = Padding(
    padding: const EdgeInsetsDirectional.all(5),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        height: 1,
        width: size!.width,
        color: Colors.grey.shade300,
      ),
    ),
  );
}
