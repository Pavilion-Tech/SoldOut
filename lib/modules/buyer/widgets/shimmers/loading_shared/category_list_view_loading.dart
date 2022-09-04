import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../shared/components/constants.dart';



class CategoryListViewLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height * .046,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            categoryListView(),
        separatorBuilder: (context, index) => SizedBox(
          width: size!.height * .016,
        ),
        itemCount: 4,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget categoryListView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        width: size!.width * .225,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(12),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
