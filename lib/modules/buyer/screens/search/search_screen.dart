import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/widgets/loadings/grid_view_loading/grid_view_loading.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
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
    suffix = Suffix(apply: () {
      BuyerCubit.get(context).getListProductsForSearch(
        text: searchController.text,
        sort: suffix!.sort!.sortValue,
        page: BuyerCubit.get(context).currentSearchPage,
      );
      Navigator.pop(context);
    });
    return Scaffold(
      body: BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyerCubit.get(context);
          return SingleChildScrollView(
            controller: BuyerCubit.get(context).scrollControllerForSearch,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                myAppBar(
                  context: context,
                  isArrowBack: true,
                  title: tr('result'),
                  isLastIcon: true,
                  lastIcon: Icons.shopping_cart,
                  arrowTap: (){
                    cubit.getHomeData(context);
                    cubit.currentSearchPage = 1;
                    cubit.scrollControllerForSearch.removeListener((){});
                    Navigator.pop(context);
                  },
                  lastButtonTap: () {
                    BuyerCubit.get(context).currentIndex = 2;
                    navigateAndFinish(context, BuyerLayout());
                  },
                ),
                ConditionalBuilder(
                    condition: cubit.searchModel != null,
                    fallback: (context) => GridViewLoading(),
                    builder: (context) {
                      cubit.getMoreForSearch();
                      return MyContainer(
                        Column(
                          children: [
                            defaultTextField(
                                controller: cubit.searchController,
                                hint: tr('search_by_product'),
                                suffix: suffix,
                                onChanged: (String? value) {
                                  if (value!.length > 1) {
                                    cubit.currentSearchPage = 1;
                                      cubit.getListProductsForSearch(
                                          text: value,
                                          sort: suffix!.sort!.sortValue
                                      );
                                  }
                                }),
                            if (cubit.searchModel!.data!.products!.isNotEmpty)
                              GridViewWidget(
                                products: cubit.searchModel!.data!.products!,)
                            else
                              Column(
                                children: [
                                  SizedBox(
                                    height: size!.height * .4,
                                  ),
                                  Text(tr('no_items_yet'))
                                ],
                              ),
                            if(state is SearchLoadingState)
                              const CircularProgressIndicator(),
                          ],
                        ),
                        noSize: true,
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}