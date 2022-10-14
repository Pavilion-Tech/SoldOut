import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soldout/modules/buyer/widgets/shimmers/home_loading/slider_loading.dart';
import '../../../../../shared/components/constants.dart';
import '../loading_shared/category_list_view_loading.dart';
import 'list_auction_loading.dart';
import 'list_product_loading.dart';

class HomeLoading extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: size!.height * .11,
            right: size!.width * .05,
            left: size!.width * .05,
            bottom: size!.height * .003,
          ),
          child: Column(
            children: [
              const CarouselSliderLoading(),
              CategoryListViewLoading(),
            ],
          ),
        ),
        Column(
          children: [
            seeMore,
            Container(
                height: size!.height >600 ? size!.height * .197:size!.height * .225,
                alignment: AlignmentDirectional.centerStart,
                padding:
                EdgeInsetsDirectional.only(start: size!.width * .050),
                child:const ListProductsLoading()
            ),
            seeMore,
            Container(
                height: size!.height >600 ? size!.height * .197:size!.height * .225,
                alignment: AlignmentDirectional.centerStart,
                padding:
                EdgeInsetsDirectional.only(start: size!.width * .050),
                child:const ListAuctionsLoading()),
            SizedBox(height: size!.height * .02),
          ],
        ),
      ],
    );
  }

  Widget seeMore = Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size!.width * .05,
        vertical: size!.height * .020),
      child: Row(
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
          const Spacer(),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: 20,
              width: 20,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
  );



}
