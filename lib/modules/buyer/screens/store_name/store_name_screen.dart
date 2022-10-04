

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../layout/buyer_layout/cubit/buyer_states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/loadings/grid_view_loading/grid_view_loading.dart';
import '../../../widgets/my_container.dart';
import '../../widgets/items_shared/grid_view.dart';
import '../../widgets/sort/suffix.dart';

class StoreNameScreen extends StatelessWidget {
  StoreNameScreen({required this.id, this.title});

  int id;
  String? title;

  TextEditingController searchController = TextEditingController();

  Suffix? suffix;

  @override
  Widget build(BuildContext context) {
    var cubit = BuyerCubit.get(context);
    suffix = Suffix(apply: () {
      cubit.getListProductsForStore(
          text: cubit.storeController.text.trim(),
          sort: suffix!.sort!.sortValue,
          id: id,
          page: cubit.currentStorePage);
      Navigator.pop(context);
    });
    return Scaffold(
      body: BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyerCubit.get(context);
          return SingleChildScrollView(
            controller: cubit.scrollControllerForStore,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                myAppBar(
                  context: context,
                  isArrowBack: true,
                  title: title ??
                      cubit.storeModel?.data?.products?[0].store?.name ??
                      tr('store_name'),
                  isLastIcon: true,
                  lastIcon: Icons.shopping_cart,
                  lastButtonTap: () {
                    cubit.currentIndex = 2;
                    navigateAndFinish(context, BuyerLayout());
                  },
                  arrowTap: (){
                    cubit.scrollControllerForStore.removeListener(() {});
                    Navigator.pop(context);
                  }
                ),
                ConditionalBuilder(
                  condition: cubit.storeModel != null,
                  builder: (context) {
                    cubit.getMoreForStore(id);
                    return MyContainer(
                      noSize: true,
                      Column(
                        children: [
                          defaultTextField(
                              controller: cubit.storeController,
                              hint: tr('search_by_product'),
                              suffix: suffix,
                              onChanged: (String? value) {
                                if (value!.length > 1) {
                                  cubit.currentStorePage = 1;
                                  cubit.getListProductsForStore(
                                      text: value,
                                      id: id,
                                      sort: suffix!.sort!.sortValue);
                                }else{
                                  cubit.getListProductsForStore(
                                      id: id,
                                      sort: suffix!.sort!.sortValue);
                                }
                              }),
                          ConditionalBuilder(
                              condition:
                                  cubit.storeModel!.data!.products!.isNotEmpty,
                              builder: (context) {
                                return GridViewWidget(
                                    products:
                                        cubit.storeModel!.data!.products!);
                              },
                              fallback: (context) => Column(
                                    children: [
                                      SizedBox(
                                        height: size!.height * .4,
                                      ),
                                      Text(tr('no_items_yet'))
                                    ],
                                  )),
                          if(state is SearchLoadingState)
                            const CircularProgressIndicator(),
                        ],
                      ),
                    );
                  },
                  fallback: (context) => GridViewLoading(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
