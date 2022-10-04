import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:video_player/video_player.dart';

class ScrollHintScreen extends StatefulWidget {
  const ScrollHintScreen({super.key});

  @override
  State<ScrollHintScreen> createState() => _ScrollHintScreenState();
}

class _ScrollHintScreenState extends State<ScrollHintScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/images/video.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.play();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Container(
                    height: size!.height * .7,
                    width: size!.width,
                    decoration: BoxDecoration(
                        color: HexColor('#545461'),
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(100),
                          bottomStart: Radius.circular(100),
                        )),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size!.height * .15,
                      ),
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'List of your Shipments',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      Text(
                        'Swipe between your shipments and track it',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade300),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      isFirst = true;
                      navigateAndFinish(context, BuyerLayout());
                      CacheHelper.saveData(key: 'isFirst', value: true);
                    },
                    child: SizedBox(
                      height: size!.height,
                      width: size!.width,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}
