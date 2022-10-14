import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class SuffixWidget extends StatefulWidget {

  int value = 0;

  @override
  State<SuffixWidget> createState() => _SuffixWidgetState();
}

class _SuffixWidgetState extends State<SuffixWidget> {

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: size!.height * .03,
          width: 1,
          color: Colors.grey.shade200,
        ),
        SizedBox(
          width: size!.width * .05,
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: defaultColorTwo,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(15),
                    topEnd: Radius.circular(15),
                  )),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              builder: (context) => StatefulBuilder(
                  builder: (context, setStateSB) =>
                      sortSheet(setStateSB)),
            );
          },
          child: Icon(
            Icons.filter_alt_outlined,
            size: 30,
            color: Colors.grey.shade400,
          ),
        )
      ],
    );
  }

  Widget sortSheet(setState) {
    return Container(
      height: size!.height > 600 ? size!.height * .29:size!.height * .45,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            tr('auction_status'),
            style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          SizedBox(
            height: size!.height * .0125,
          ),
          RadioListTile(
            value: 0,
            groupValue: widget.value,
            selected: widget.value == 0,
            onChanged: (int? value) {
              setState(() {
                widget.value = value!;
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('processing2'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          RadioListTile(
            value: 1,
            groupValue: widget.value,
            selected: widget.value == 1,
            onChanged: (int? value) {
              setState(() {
                widget.value = value!;
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('finished'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size!.height > 600 ? 20:15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                defaultButton(
                  onTap: ()=>Navigator.pop(context),
                  text: tr('discard'),
                  textColor: defaultColor,
                  buttonColor: defaultColorTwo,
                ),
                SizedBox(width: size!.height * .008,),
                defaultButton(
                    onTap: () {
                      AuctionCubit.get(context).sort(widget.value);
                      Navigator.pop(context);
                    },
                    text: tr('apply')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
