import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../../shared/components/constants.dart';
import '../../../../../../widgets/my_container.dart';

class RateAndReview extends StatefulWidget {
  RateAndReview({required this.id});

  int id;
  @override
  State<RateAndReview> createState() => _RateAndReviewState();
}

class _RateAndReviewState extends State<RateAndReview> {
  double rate = 0;

  TextEditingController reviewC = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SettingsCubit.get(context);
          return SingleChildScrollView(
            child: Stack(
              children: [
                myAppBar(
                    context: context,
                    title: tr('rate_review'),
                    isArrowBack: true,
                    isLastIcon: true,
                    lastIcon: Icons.shopping_cart,
                    lastButtonTap: () {
                      BuyerCubit.get(context).changeIndex(2);
                      navigateAndFinish(context, BuyerLayout());
                    }),
                MyContainer(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('how_would_rate'),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: size!.height * .15,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: defaultColorTwo,
                          borderRadius: BorderRadiusDirectional.circular(15),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('tap_on_stars'),
                              style: TextStyle(
                                  color: HexColor('#A0AEC0'), fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RatingBar.builder(
                              initialRating: rate,
                              itemSize: 40,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              allowHalfRating: true,
                              unratedColor: HexColor('#FFE000'),
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, index) {
                                if (rate > index) {
                                  return Image.asset(BuyerImages.fullStar);
                                } else {
                                  return Icon(
                                    Icons.star_border,
                                    color: HexColor('#FFE000'),
                                  );
                                }
                              },
                              onRatingUpdate: (rating) {
                                setState(() {
                                  rate = rating;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          tr('leave_comment'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Container(
                          height: size!.height * .15,
                          decoration: BoxDecoration(
                            color: defaultColorTwo,
                            borderRadius: BorderRadiusDirectional.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: TextFormField(
                            controller: reviewC,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: tr('tell_us_more'),
                              hintStyle: TextStyle(
                                  color: HexColor('#A0AEC0'),
                                  fontSize: 13,
                                  height: 5),
                            ),
                            maxLines: 5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: state is! RateLoadingState
                            ? defaultButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.rateProduct(
                                        id: widget.id,
                                        rate: rate,
                                        review: reviewC.text,
                                        context: context);
                                  }
                                },
                                text: tr('submit_review'))
                            : const CircularProgressIndicator(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
