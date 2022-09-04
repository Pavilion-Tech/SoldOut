import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soldout/modules/vendor/screens/add_product/add_screen.dart';
import 'package:soldout/modules/vendor/screens/notification/notification_screen.dart';
import '../../../modules/vendor/screens/home/home_screen.dart';
import '../../../modules/vendor/screens/order/vendor_order_screen.dart';
import '../../../modules/vendor/screens/settings/vendor_settings_screen.dart';
import 'vendor_states.dart';

class VendorCubit extends Cubit<VendorStates>{
  VendorCubit(): super(InitState());

  static VendorCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;

  bool showAuctionHint= true;

  List<Widget> screens = [
    VendorHomeScreen(),
    const VendorNotificationHomeScreen(),
    const VendorAddProductScreen(),
    const VendorOrderScreen(),
    const VendorSettingsScreen(),
  ];

  void changeAuctionHint(){
    showAuctionHint = !showAuctionHint;
    emit(ChangeAuctionHintState());
  }

  void changeIndex(int index){
    currentIndex = index;
    imageFileList.clear();
    emit(ChangeIndexState());
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      emit(ImagesPickedState());
    }
  }

  File? file;

  void selectFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      emit(FilePickedState());
    } else {
      // User canceled the picker
    }
  }

}