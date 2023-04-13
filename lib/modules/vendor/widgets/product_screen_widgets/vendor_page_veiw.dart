import 'package:flutter/material.dart';
import 'package:soldout/shared/components/constants.dart';

import '../../../../models/buyer_model/product_model/images_model.dart';
import '../../../widgets/image_net.dart';

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
        itemBuilder: (context, index) => ImageNet(image:images[index].image!),
        itemCount: images.length,
        onPageChanged: (int index) {},
        controller: pageController,
      ),
    );
  }

}