import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soldout/layout/vendor_layout/vendor_layout_screen.dart';
import 'package:soldout/models/buyer_model/product_model/product_model.dart';
import 'package:soldout/modules/vendor/screens/add_product/add_screen.dart';
import 'package:soldout/modules/vendor/screens/notification/notification_screen.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import '../../../models/buyer_model/list_products_model.dart';
import '../../../models/notification_model.dart';
import '../../../models/vendor_model/statistics_model.dart';
import '../../../models/vendor_model/vendor_order_model.dart';
import '../../../modules/vendor/screens/home/home_screen.dart';
import '../../../modules/vendor/screens/order/vendor_order_screen.dart';
import '../../../modules/vendor/screens/settings/vendor_settings_screen.dart';
import '../../../shared/firebase_helper/dynamic_links.dart';
import '../../../shared/network/remote/dio.dart';
import '../../../shared/network/remote/end_point.dart';
import '../../buyer_layout/cubit/buyer_cubit.dart';
import 'vendor_states.dart';

class VendorCubit extends Cubit<VendorStates>{
  VendorCubit(): super(InitState());

  static VendorCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;

  GetStatistics? getStatistics;

  ListProductModel? listProductModel;

  VendorOrderModel? vendorOrderModel;

  VendorOrderData? searchModel;

  NotificationModel? notificationModel;

  int pageProduct = 1;

  TextEditingController searchC = TextEditingController();

  TextEditingController nameC = TextEditingController();

  TextEditingController descC = TextEditingController();

  TextEditingController qnt = TextEditingController();

  TextEditingController weight = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController priceAfterDiscount = TextEditingController();

  String? dropDownValue;

  int? dropDownId;

  final ImagePicker imagePicker = ImagePicker();

  List<File> imageFileList = [];

  List<File> listImage = [];

  List<int> imagesId = [];

  List<Widget> screens = [
    VendorHomeScreen(),
    const VendorNotificationHomeScreen(),
    const VendorAddProductScreen(),
    const VendorOrderScreen(),
    const VendorSettingsScreen(),
  ];

  void checkInterNet()async{
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
  }

  void dynamicLink(context){
    DynamicLinksClient.initDynamicLinks((String? value)
    {
      if(value!=null){
        BuyerCubit.get(context).getProduct(id: int.parse(value));
      }
    });
  }


  Future<File> getImage({required String url}) async {

    final Response res = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    final Directory appDir = await getApplicationDocumentsDirectory();

    final String imageName = url.split('/').last;

    final File file = File(join(appDir.path, imageName));
    file.writeAsBytes(res.data as List<int>);
    return file;
  }

  Future addImageToList (String url)async
  {
    imageFileList.add(await getImage(url:url));
    emit(JustEmitState());
  }

  void justEmit(){
    emit(JustEmitState());
  }

  void changeIndex(int index){
    currentIndex = index;
    if(index == 3)getOrder();
    emit(ChangeIndexState());
  }

  void selectImages() async {
    var images = await imagePicker.pickMultiImage();
    if (images!.isNotEmpty) {
      for(var image in images)
      {
        imageFileList.add(File(image.path));
        listImage.add(File(image.path));
      }
      emit(ImagesPickedState());
    }
  }

  void getStatistic({String? startDate,String? lastDate,BuildContext? context})async
  {
    if(!isConnect!)checkNet(context);
    String? checkUrl = lastDate!= null
        ? '/stores/getStatistics?start_date=$startDate&end_date=$lastDate'
        : null;
    String url = checkUrl??'/stores/getStatistics?start_date&end_date';
    await DioHelper.getData(
      token: 'Bearer $vToken',
      url: url,
      lang: myLocale,
    ).then((value) {
      if(value.statusCode == 200 && value.data['status'])
      {
        getStatistics = GetStatistics.fromJson(value.data);
        emit(GetStatisticSuccessState());
      }else if(value.data!=null&&!value.data['status']){
        showToast(msg: value.data['errors'].toString());
        emit(GetStatisticWrongState());
      }
    }).catchError((e){
      emit(GetStatisticErrorState());
    });
  }

  void getProducts({
    String? text,
    int? sort,
    int page = 1,
    bool isPage = false,
  })async
  {
    String url = '/stores/products?search_text=${text??''}&page=$page${sort!= null ?'&sort_type=':''}${sort??''}';
    emit(GetProductLoadingState());
    await DioHelper.getData(
      url:url,
      token: 'Bearer $vToken',
      lang: myLocale,
    ).then((value) {
      if(isPage)
      {
        listProductModel!.data!.lastPage=value.data['data']['last_page'];
        listProductModel!.data!.currentPage=value.data['data']['current_page'];
        for(Map<String,dynamic>product in value.data['data']['products'])
        {
          listProductModel!.data!.products!.add(ProductModel.fromJson(product));
          emit(GetProductSuccessState());
        }
        emit(GetProductSuccessState());
      }else
        {
          listProductModel = ListProductModel.fromJson(value.data);
          emit(GetProductSuccessState());
        }

    }).catchError((e){
      emit(GetProductErrorState());
    });
  }

  void product({
    required bool isEdit,
     int? productId,
     int? cateId,

})async
  {
    FormData formData = FormData.fromMap({
      'name':nameC.text,
      'desc':descC.text,
      'stock':qnt.text,
      'weight':weight.text,
      'regular_price':price.text,
      'sale_price':priceAfterDiscount.text,
      'category_id':cateId,
      'images[]':  listImage.map((item)=> MultipartFile.fromFileSync(item.path,
          filename: item.path.split('/').last)).toList(),
    });
    FormData formDataForEdit = FormData.fromMap({
      'product_id':productId,
      'name':nameC.text,
      'desc':descC.text,
      'stock':qnt.text,
      'weight':weight.text,
      'regular_price':price.text,
      'sale_price':priceAfterDiscount.text,
      'category_id':cateId,
      'available_images[]':imagesId,
      'images[]':  listImage.map((item)=> MultipartFile.fromFileSync(item.path,
          filename: item.path.split('/').last)).toList(),
    });
    emit(ProductLoadingState());
    await DioHelper.postData2(
      url:isEdit ?vEditProducts : vProducts,
      token: 'Bearer $vToken',
      lang: myLocale,
      formData:isEdit ?formDataForEdit :  formData
    ).then((value) {
      if(value.statusCode==200&&value.data['status']){
        showToast(msg: isEdit?tr('item_edited'):tr('item_added'));
        nullingData();
        getProducts();
        emit(ProductSuccessState());
      }else if (value.data!= null&&!value.data['status'])
      {
        showToast(msg: value.data['errors'].toString(),toastState: true);
        emit(ProductWrongState());
      }else {
        showToast(msg: tr('wrong'),toastState: true);
        emit(ProductWrongState());
      }
    }).catchError((e){
      emit(ProductErrorState());
    });
  }

  void nullingData()
  {
  nameC.text = '';
  descC.text = '';
  qnt.text='';
  weight.text='';
  price.text='';
  priceAfterDiscount.text='';
  imageFileList.clear();
  dropDownValue=null;
  dropDownId=null;
  imagesId.clear();
  listImage.clear();
  }


  void deleteProduct(int id,context)async
  {
    emit(DeleteProductLoadingState());
    await DioHelper.postData(
      url: vDeleteProduct,
      token: 'Bearer $vToken',
      data: {
        'product_id':id
      }
    ).then((value) {
      showToast(msg: tr('product_deleted'));
      getProducts();
      navigateAndFinish(context, VendorLayout());
      emit(DeleteProductSuccessState());
    }).catchError((e){
      emit(DeleteProductErrorState());
    });
  }

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();


  void getMoreForProducts(){
    scrollController.addListener(() {
    if(state is! GetProductLoadingState)
    {
      if(scrollController.offset==scrollController.position.maxScrollExtent){
        if(listProductModel!.data!.currentPage != listProductModel!.data!.lastPage){
          pageProduct++;
          getProducts(
            text: searchController.text.trim(),
            page: pageProduct,
            isPage: true
          );
        }
      }
    }
    });
  }
  
  
  void getOrder()async
  {
    emit(GetOrderLoadingState());
    await DioHelper.getData(
        url: vOrder,
        token: 'Bearer $vToken'
    ).then((value){
      if(value.statusCode==200&&value.data['status']){
        vendorOrderModel = VendorOrderModel.fromJson(value.data);
        emit(GetOrderSuccessState());
      }else {
        showToast(msg: tr('wrong'),toastState: true);
        emit(GetOrderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetOrderErrorState());
    });
  }

  void searchOrder(int id)
  {
    for(var order in vendorOrderModel!.data!)
    {
      if(order.id == id )
      {
        searchModel = order;
        emit(SearchState());
      }
    }
  }

   void nullSearch()
  {
    searchModel = null;
    emit(SearchState());
  }

  void getNotifications()async
  {
    emit(GetNotificationLoadingState());
    await DioHelper.getData(
        url: fetchVNotification,
        token: 'Bearer $vToken',
        lang: myLocale
    ).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      emit(GetNotificationSuccessState());
    }).catchError((e){
      emit(GetNotificationErrorState());
    });
  }
}