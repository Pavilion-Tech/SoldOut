import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/widgets/paymen/payment_dialog.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../shared/components/components.dart';
import '../../../widgets/my_container.dart';

class Payment extends StatefulWidget {
  Payment({required this.url,this.isPoints = false});
  String url;
  bool isPoints;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  bool isLoading = true;

  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            print('onPageStarted $url');
          },
          onPageFinished: (String url) {
            print('onPageFinished $url');
            setState(()=>isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            Navigator.pop(context);
            error.toString();
          },
          onUrlChange: (UrlChange url){
            Uri uri = Uri.parse(url.url??'');
            if(uri.queryParameters['Result'] !=null)
            if(uri.queryParameters['Result']=='Successful'){
              showDialog(
                  context: context,
                  builder: (context)=>PaymentCheckOutDialog(true)
              );
            }else{
              showDialog(
                  context: context,
                  builder: (context)=>PaymentCheckOutDialog(false)
              );
            }
            print('onUrlChange ${uri}');
          }
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            myAppBar(
              context: context,
              isArrowBack: true,
              title: tr('payment'),
              arrowTap: () {
                if(widget.isPoints)SettingsCubit.get(context).getAllPoints();
                Navigator.pop(context);
              },
            ),
            Stack(
              children: [
                MyContainer(
                  WebViewWidget(controller: controller),
                ),
                if(isLoading)
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: size!.height*.4,),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
