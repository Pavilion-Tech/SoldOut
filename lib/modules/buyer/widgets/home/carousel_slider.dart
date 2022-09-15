import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/screens/store_name/store_name_screen.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';

class CarouselSliderWidget extends StatefulWidget {

  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    var cubit = BuyerCubit.get(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration:
          BoxDecoration(borderRadius: BorderRadiusDirectional.circular(15)),
          height: size!.height * .18,
          width: size!.width * .9,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CarouselSlider(
            items: cubit.homeModel!.data!.ads!.map((e) {
              return InkWell(
                  onTap: (){
                    if(e.type == 'external')
                    {
                      cubit.openUrl(e.link!);
                    }
                    if(e.type == 'store')
                    {
                      cubit.currentStorePage = 1;
                      cubit.getListProductsForStore(
                          id:  e.id!,
                          text: ''
                      );
                      navigateTo(context, StoreNameScreen(id: e.id!,));
                    }
                    if(e.type == 'product')
                    {
                      cubit.getProduct(
                        id: e.id!,
                        context: context
                      );
                    }

                  },
                  child: image(e.image!)
              );
            }).toList(),
            options: CarouselOptions(
              onPageChanged: (int page, CarouselPageChangedReason changedReason) {
                setState(() {
                  _index = page;
                });
              },
              height:size!.height * .18,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size!.height * .010),
          child: SizedBox(
            height: 20,
            width: double.infinity,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=>_index == index
                  ? customIndicatorOn(): customIndicatorOff(),
              separatorBuilder: (context,index)=>const SizedBox(width: 3,),
              itemCount: cubit.homeModel!.data!.ads!.length,
            ),
          )
        ),
      ],
    );
  }

  Widget customIndicatorOn() => Image.asset(BuyerImages.indicatorOn,height: 20,width: 20,);
  Widget customIndicatorOff() => Image.asset(BuyerImages.indicatorOff,height: 20,width: 20,);

  Widget image(String url){
    return Image.network(
      url,
      width: size!.width * .9,
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
