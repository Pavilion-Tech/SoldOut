import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class MIndicator extends StatelessWidget {
  MIndicator({required this.pageController,required this.lengthPageView});

  PageController pageController;
  int lengthPageView;

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      textDirection: myLocale == 'ar' ? TextDirection.rtl:TextDirection.ltr,
        top: size!.height * .33,
        start: size!.width * .45,
        child: SmoothPageIndicator(
          controller: pageController, // PageController
          count: lengthPageView,
          effect: const WormEffect(
              dotColor: defaultColorTwo,
              activeDotColor: defaultColor,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 4.0), // your preferred effect
        ));
  }
}
