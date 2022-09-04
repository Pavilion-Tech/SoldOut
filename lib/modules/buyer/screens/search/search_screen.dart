import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/widgets/loadings/grid_view_loading/grid_view_loading.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../widgets/items_shared/grid_view.dart';
import '../../widgets/sort/suffix.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  Suffix? suffix;


  @override
  Widget build(BuildContext context) {
    suffix = Suffix(apply:(){
      BuyerCubit.get(context).search(
        text: searchController.text.trim(),
          sort:suffix!.sort!.sortValue
      );
      Navigator.pop(context);
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            myAppBar(
              context: context,
              isArrowBack: true,
              title: tr('result'),
              isLastIcon: true,
              lastIcon: Icons.shopping_cart,
              lastButtonTap: () {
                BuyerCubit
                    .get(context)
                    .currentIndex = 2;
                navigateAndFinish(context, BuyerLayout());
              },
            ),
            BlocConsumer<BuyerCubit, BuyerStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = BuyerCubit.get(context);
                return ConditionalBuilder(
                    condition:cubit.searchModel!= null,
                    fallback: (context)=>GridViewLoading(),
                    builder:(context)=>MyContainer(
                      Column(
                        children: [
                          defaultTextField(
                              controller: searchController,
                              hint: tr('search_by_product'),
                              suffix:suffix,
                              onChanged: (String? value){
                                if(value!.length >1 ){
                                  cubit.search(text: value);
                                }
                              }
                          ),
                          if(cubit.searchModel!.data!.products!.isNotEmpty)
                             GridViewWidget(products:cubit.searchModel!.data!.products!,)
                          else Column(children:const[SizedBox(height: 100,),Text('No Items Yet')],),


                        ],
                      ),
                      noSize: true,
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
