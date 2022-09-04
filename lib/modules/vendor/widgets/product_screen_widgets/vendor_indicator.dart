import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class VIndicator extends StatelessWidget {
  VIndicator({required this.pageController});

  PageController pageController;
  int lengthPageView = 4;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size!.height * .33,
        right: size!.width * .35,
        left: size!.width * .45,
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
