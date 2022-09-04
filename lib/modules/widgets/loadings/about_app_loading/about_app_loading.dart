import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AboutAppLoading extends StatelessWidget {
  const AboutAppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,indxe){
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: 20,
            width: double.infinity,
            color: Colors.grey,
          ),
        );
        },
        separatorBuilder: (context,indxe){
          return SizedBox(height: 20,);
        },
        itemCount: 30,
    );
  }
}
