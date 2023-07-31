import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/models/buyer_model/product_model/product_model.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../shared/components/constants.dart';
import '../../widgets/items_shared/grid_view.dart';
import '../../widgets/sort/suffix.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({required this.products,required this.name,required this.id});

  List<ProductModel> products;
  String name;
  int id;


  TextEditingController searchController = TextEditingController();

  Suffix? suffix;

  @override
  Widget build(BuildContext context) {
    suffix = Suffix(apply: () {
      BuyerCubit.get(context).getListProductsForCategory(
          text: searchController.text,
          sort: suffix!.sort!.sortValue,
          id: id,
          page: BuyerCubit.get(context).currentCategoryPage,
      );
      Navigator.pop(context);
    });
    return Scaffold(
      body: BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyerCubit.get(context);
          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              myAppBar(
                context: context,
                isArrowBack: true,
                title: name,
                isLastIcon: true,
                lastIcon: Icons.shopping_cart,
                lastButtonTap: () {
                 cubit.currentIndex = 2;
                  navigateAndFinish(context, BuyerLayout());
                },
                arrowTap: (){
                  BuyerCubit.get(context).getHomeData(context);
                  cubit.currentCategoryPage = 1;
                  cubit.scrollControllerForCategory.removeListener(() {});
                  Navigator.pop(context);
                }
              ),
              MyContainer(
                  noSize: true,
                  ConditionalBuilder(
                    condition:products.isNotEmpty,
                    fallback: (context)=>Column(children: [
                      SizedBox(height: size!.height*.4,),
                      Text(tr('no_items_yet')),
                    ],),
                    builder: (context)=>Column(
                      children: [
                        defaultTextField(
                            controller: cubit.categoryController,
                            hint: tr('search_by_product'),
                            suffix: suffix,
                            onChanged: (String? value) {
                              if (value!.length > 1) {
                                cubit.currentCategoryPage = 1;
                                cubit.getListProductsForCategory(
                                    text: value,
                                    id: id,
                                    sort: suffix!.sort!.sortValue
                                );
                              }
                              if (value.length < 2) {
                                cubit.currentCategoryPage = 1;
                                cubit.categoryModel = null;
                                cubit.emitState();
                              }
                            }
                        ),
                        if(cubit.categoryModel != null)
                          Builder(builder:(context)
                          {
                            cubit.getMoreForCategory(id);
                            return Expanded(
                              child: GridViewWidget(
                                  products: cubit.categoryModel!.data!.products!,
                                isScroll: true,
                              ),
                            );

                          }),
                        if(cubit.categoryModel == null)
                          Expanded(child: GridViewWidget(
                              products: products,
                            isScroll: true,

                          )),
                        if(state is SearchLoadingState)
                          const CircularProgressIndicator(),
                      ],
                    )
                  )
              ),
              Container(
                width: size!.width,
                height: size!.height,
                child: cubit.flyingCart == null ? Container() : cubit.flyingCart,
              )
            ],
          );
        },
      ),
    );
  }
}
