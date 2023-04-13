import 'package:flutter/material.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../select_type/select_type.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  List<String> descs = [
    "Welcome, join the Savvy Save community and get exceptional customer service and high-quality products",
    "Enjoy a unique shopping experience with an easy-to-use app and the largest collection of products.",
    "Shop with us now and get the best exclusive deals and offers on your favourite products.",
  ];

  var pageController = PageController();
  int _index = 0;


  Widget customIndicatorOn = Image.asset(BuyerImages.indicatorOn,height: 20,width: 20,);
  Widget customIndicatorOff =Image.asset(BuyerImages.indicatorOff,height: 20,width: 20,);


  void submit()
  {
    onBoarding = true;
    CacheHelper.saveData(key: 'onBoarding', value: onBoarding,).then((value)
    {
     navigateAndFinish(context, const SelectType());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(size!.height* .016),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildItem(descs[index]),
                itemCount: 3,
                onPageChanged: (int index)
                {
                  setState(() {
                    _index = index;
                  });
                },
                controller: pageController,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: size!.height* .030,
            ),
            Row(
              children: [
                _index == 0 ? customIndicatorOn: customIndicatorOff,
                const SizedBox(width: 3,),
                _index == 1 ? customIndicatorOn: customIndicatorOff,
                const SizedBox(width: 3,),
                _index == 2 ? customIndicatorOn: customIndicatorOff,
                const Spacer(),
                InkWell(
                    onTap: (){
                      submit();
                    },
                    child: Image.asset(BuyerImages.skip,height: 35,width: 35,),),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget buildItem(String desc) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Expanded(
        child: SizedBox(),
      ),
      Text(
        desc,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 12,
            height: 2
        ),
      ),
      SizedBox(
        height: size!.height* .010,
      ),
    ],
  );


}





