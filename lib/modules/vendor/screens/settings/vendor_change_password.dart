import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

class VChangePassword extends StatelessWidget {
  const VChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
              context: context,
              title: tr('change_password'),
              isArrowBack: true,
            ),
            MyContainer(
              Column(
                children: [
                  defaultTextField(
                      controller: TextEditingController(),
                      hint: tr('old_password'),
                      suffix: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.visibility,color: HexColor('#A0AEC0'),),
                      )
                  ),
                  SizedBox(height: 15,),
                  defaultTextField(
                      controller: TextEditingController(),
                      hint: tr('new_password'),
                      suffix: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.visibility,color: HexColor('#A0AEC0'),),
                      )
                  ),
                  SizedBox(height: 15,),
                  defaultTextField(
                      controller: TextEditingController(),
                      hint: tr('confirm_new_password'),
                      suffix: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.visibility,color: HexColor('#A0AEC0'),),
                      )
                  ),
                  SizedBox(height: 15,),
                  defaultButton(onTap: (){}, text: tr('save'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
