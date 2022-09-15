import 'package:flutter/material.dart';
import 'package:soldout/shared/components/constants.dart';

import '../../../../models/buyer_model/product_model/images_model.dart';

class VPageView extends StatelessWidget
{

  VPageView({required this.pageController,required this.images});
  PageController pageController;
  List<Images> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size!.height * .385,
      width: double.infinity,
      child: PageView.builder(
        itemBuilder: (context, index) => pageViewItem(images[index].image!),
        itemCount: images.length,
        onPageChanged: (int index) {},
        controller: pageController,
      ),
    );
  }

  Widget pageViewItem(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (c,o,s)=>const Icon(Icons.info),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }


}