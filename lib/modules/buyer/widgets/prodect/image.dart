import 'package:flutter/material.dart';

import '../../../../models/buyer_model/product_model/images_model.dart';
import '../../../../shared/components/constants.dart';
import '../items_shared/indicator.dart';

class ShowImage extends StatelessWidget {

  ShowImage(this.images);

  List<Images> images;
  PageController pageController = PageController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: size!.height,
          width: size!.width,
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                  icon:Icon(Icons.arrow_back_ios,color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height:size!.height*.1 ,),
              Stack(
                children: [
                  SizedBox(
                    height: size!.height * .7,
                    width: double.infinity,
                    child: PageView.builder(
                      itemBuilder: (context, index) => zoomImage(images[index].image!),
                      itemCount: images.length,
                      onPageChanged: (int index) {},
                      controller: pageController,
                    ),
                  ),
                  MIndicator(
                    pageController: pageController,
                    lengthPageView: images.length,
                    zoomSize: size!.height*.68,
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget zoomImage (String url){
    return InteractiveViewer(
      clipBehavior: Clip.none,
      child: Image.network(
        url,
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
      ),
    );
  }
}
