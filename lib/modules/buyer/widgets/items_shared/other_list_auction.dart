import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/widgets/home/auction_item.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../home/category_list_view.dart';
import '../../../widgets/my_container.dart';

class OtherListAuctions extends StatelessWidget {
  OtherListAuctions({this.isMyAuction = false});

  bool isMyAuction;
  int _value = 1;
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
        noSize: true,
        Column(
          children: [
            isMyAuction
                ?  defaultTextField(
                controller: TextEditingController(),
                hint: tr('search_by_auction'),
                suffix:suffixWidget(context))
                : CategoryListView(),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              crossAxisCount: 2,
              children: List.generate(
                6, (index) =>AuctionItem(
                  title: 'First Auction',
                  state: 'New',
                  time: '10:20:30',
              ) ,
              ),
            ),
          ],
        ),
    );
  }


  Widget sortSheet(setState) {
    return Container(
      height: size!.height * .28,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsetsDirectional.only(top: 20,bottom: 20),
      child: Column(
        children: [
          Text(tr('sorting_by'),style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: size!.height * .0125,
          ),
          RadioListTile(
            value: 1,
            groupValue: _value,
            selected: isSelected,
            dense: !isSelected,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
                isSelected = !isSelected;
              });
            },
            activeColor: defaultColor,
            title: Text(tr('price_high_to_low')),
          ),
          RadioListTile(
            value: 2,
            groupValue: _value,
            selected: !isSelected,
            dense: isSelected,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
                isSelected = !isSelected;
              });
            },
            activeColor: defaultColor,
            title: Text(tr('price_low_to_high')),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                defaultButton(
                  onTap: () {},
                  text: tr('discard'),
                  textColor: defaultColor,
                  buttonColor: defaultColorTwo,
                ),
                SizedBox(
                  width: size!.height * .008,
                ),
                defaultButton( onTap: () {}, text: tr('apply')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget suffixWidget(context){
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

}
