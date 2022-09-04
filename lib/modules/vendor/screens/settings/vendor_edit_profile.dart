import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/my_container.dart';
class VEditProfile extends StatelessWidget {
  const VEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('edit_profile'),
                isArrowBack: true,

            ),
            MyContainer(
              Column(
                children: [
                  defaultTextField(
                    controller: TextEditingController(),
                    hint: tr('store_name'),
                  ),
                  SizedBox(height: 15,),
                  defaultTextField(
                      controller: TextEditingController(),
                      hint: tr('phone'),
                      type: TextInputType.phone
                  ),
                  SizedBox(height: 15,),
                  defaultTextField(
                      controller: TextEditingController(),
                      hint: tr('email_address_two'),
                  ),
                  SizedBox(height: 15,),
                  defaultTextField(
                      controller: TextEditingController(),
                      hint: tr('attach_register'),
                    readOnly: true,
                    onTap: (){
                        VendorCubit.get(context).selectFile();
                    }
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