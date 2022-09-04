import 'package:flutter/cupertino.dart';
import 'package:soldout/shared/components/constants.dart';

class VPageView extends StatelessWidget
{

  VPageView({required this.pageController});
  PageController pageController;
  int lengthPageView = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height * .385,
      width: double.infinity,
      child: PageView.builder(
        itemBuilder: (context, index) => pageViewItem(),
        itemCount: lengthPageView,
        onPageChanged: (int index) {},
        controller: pageController,
      ),
    );
  }

  Widget pageViewItem() {
    return Image.network(
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      fit: BoxFit.cover,
    );
  }


}