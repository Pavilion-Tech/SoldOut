import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import 'delet_dialog.dart';

class EditProductWidget extends StatelessWidget {
  const EditProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          tr('determine'),
          style:const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          tr('indicates'),
          style:const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 15,),
        defaultTextField(controller: TextEditingController(), hint: tr('product_name')),
        const SizedBox(height: 15,),
        Container(
          height: size!.height*.2,
          decoration: BoxDecoration(
            color: defaultColorTwo,
            borderRadius: BorderRadiusDirectional.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: tr('Description'),
              hintStyle: TextStyle(color: HexColor('#A0AEC0'),fontSize: 16,height: 2),
            ),
            maxLines: 5,
          ),
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            Expanded(
              child:defaultTextField(
                  type: TextInputType.number,
                  controller: TextEditingController(),
                  hint: tr('quantity')
              ),),
            SizedBox(width: 10,),
            Expanded(
              child:defaultTextField(
                  type: TextInputType.number,
                  controller: TextEditingController(),
                  hint: tr('weight')),
            )
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            Expanded(
              child:defaultTextField(
                  type: TextInputType.number,
                  controller: TextEditingController(),
                  hint: tr('price')),
            ),
            SizedBox(width: 10,),
            Expanded(
              child:defaultTextField(
                  type: TextInputType.number,
                  controller: TextEditingController(),
                  hint: tr('price_after_discount'))
              ,)
          ],
        ),
        const SizedBox(height: 15,),
        InkWell(
          onTap: (){},
          child: Container(
            height: size!.height*.06,
            decoration: BoxDecoration(
              color: defaultColorTwo,
              borderRadius: BorderRadiusDirectional.circular(15),
              border: Border.all(color: Colors.grey.shade200),
            ),
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo,color: HexColor('#A0AEC0'),),
                const SizedBox(width: 10,),
                Text(
                  tr('upload_image'),
                  style:const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Align(
            alignment: AlignmentDirectional.center,
            child: defaultButton(onTap: (){}, text: tr('edit_product'))),
        const SizedBox(height: 15,),
        Align(
            alignment: AlignmentDirectional.center,
            child: TextButton(
              onPressed:(){
                showDialog(context: context, builder: (context){
                  return DeletDialog();
                });
              },
              child: Text(
                tr('delete_product'),
                style:const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
              ),
            )),
      ],
    );
  }
}
