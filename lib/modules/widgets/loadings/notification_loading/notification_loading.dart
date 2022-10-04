import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/components/constants.dart';

class NotificationListLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context,index)=>const SizedBox(height: 20,),
      itemCount: 6,
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        return Container(
          height: size!.height*.18,
          padding: const EdgeInsetsDirectional.only(
            top: 8,
            start: 8,
            bottom: 8,
            end: 16,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              border: Border.all(color: Colors.grey.shade300)
          ),
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
              const SizedBox(height: 13,),
              textItemLoading,
              textItemLoading,
              textItemLoading,
              const Spacer(),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    height: 10,
                    width: 130,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget textItemLoading = Padding(
    padding: const EdgeInsets.symmetric(vertical: 7.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        height: 15,
        width: double.infinity,
        color: Colors.grey.shade300,
      ),
    ),
  );
}
