import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/contact_us_widget.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../widgets/my_container.dart';


class VContactUsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: Stack(
            children: [
              myAppBar(
                  context: context,
                  title: tr('contact_us'),
                  isArrowBack: true,
              ),
              MyContainer(
                noSize: true,
                ContactUsWidget(),
                end: 0,
                start: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
