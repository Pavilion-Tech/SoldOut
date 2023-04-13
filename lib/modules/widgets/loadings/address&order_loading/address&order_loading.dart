import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../shared/components/constants.dart';

class AddressAndOrderLoading extends StatelessWidget {
  const AddressAndOrderLoading({Key? key}) : super(key: key);

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
          itemBuilder: (context, index) => address(),
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: 5,
          shrinkWrap: true,
          physics:const NeverScrollableScrollPhysics(),
        ),
        const SizedBox(
          height: 10,
        ),
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

  Widget address() {
    return Container(
      height: size!.height > 670 ? size!.height * .1: size!.height * .15,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(
          color: Colors.grey.shade300.withOpacity(.5),
        ),
      ),
      padding: const EdgeInsetsDirectional.all(10),
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
          const Spacer(),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: 30,
              width: size!.width,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
