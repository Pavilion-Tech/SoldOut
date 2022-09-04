import 'package:flutter/cupertino.dart';
import 'package:soldout/models/buyer_model/product_model/images_model.dart';
import 'package:soldout/shared/components/constants.dart';

class MPageView extends StatelessWidget
{

  MPageView({required this.pageController,required this.images});
  PageController pageController;
  List<Images> images;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }


}