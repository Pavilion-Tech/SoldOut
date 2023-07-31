import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/modules/widgets/wrong_screens/no_connect.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

Future<XFile?> checkImageSize (XFile? image)async{
  if(image!=null) {
    final bytes = (await image.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if(mb<5.0){
      return image;
    }else {
      showToast(msg: tr('image_size'));
      return null;
    }
  }
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastOutSlowIn;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastOutSlowIn;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    ),
        (route) => false,
  );
}

Widget defaultButton({
  required VoidCallback onTap,
  required String text,
  Color textColor = defaultColorTwo,
  Color buttonColor = defaultColor,
  Color radiusColor = defaultColor,
  double? width,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 55,
      width: width ?? size!.width * .44,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(
          color: radiusColor,
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700
        ),
      ),
    ),
  );
}

Widget defaultTextField({
  TextEditingController? controller,
  required String hint,
  TextInputType type = TextInputType.text,
  Widget? suffix,
  Color color = defaultColorTwo,
  FormFieldValidator<String>? validator,
  bool readOnly = false,
  VoidCallback? onTap,
  bool? digitsOnly,
  int? textLength,
  Function(String)? onChanged,
  bool isPassword = false,
}){
  return Stack(
    children: [
      Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
       borderRadius: BorderRadiusDirectional.circular(15),
         border: Border.all(color: Colors.grey.shade200),
        ),
      ),
      Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 15),
        child: TextFormField(
          obscureText: isPassword,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          keyboardType: type,
          style: TextStyle(height: 1.1),
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            labelText: hint,
            suffixIcon: suffix,
            labelStyle: TextStyle(color: HexColor('#A0AEC0'),fontSize: 12),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(textLength),
            if(digitsOnly!=null)FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    ],
  );
}

Widget myAppBar({
  required BuildContext context,
  required String title,
  double? height,
  bool isArrowBack = false,
  bool isLastIcon = false,
  IconData? lastIcon,
  VoidCallback? lastButtonTap,
  VoidCallback? arrowTap,
  bool isLastWidget = false,
}) {
  return Container(
    width: double.infinity,
    height: height ?? size!.height * .33,
    alignment: AlignmentDirectional.topStart,
    decoration: const BoxDecoration(
      color: defaultColor,
      borderRadius: BorderRadiusDirectional.only(
        bottomEnd: Radius.circular(15),
        bottomStart: Radius.circular(15),
      ),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.all(20),
      child: Row(
        children: [
          SizedBox(height : size!.height*.1 ),
          if (isArrowBack)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 25),
              child: InkWell(
                onTap: arrowTap ??() {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: defaultColorTwo,
                    borderRadius: BorderRadiusDirectional.circular(5),
                  ),
                  child: myLocale == 'ar'
                      ?const Icon(Icons.arrow_back_ios,size: 14,color: defaultColor,)
                      :Image.asset(BuyerImages.arrow,height: 12,width: 12,),
                ),
              ),
            ),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: defaultColorTwo,
              fontSize: size!.height >670 ? 18 : 14,
            ),
          ),
          const Spacer(),
          if (isLastIcon)
            IconButton(
                onPressed: lastButtonTap,
                icon: Icon(lastIcon,color: defaultColorTwo,)),
          if(isLastWidget)
            TextButton(
                onPressed: (){
                  navigateAndFinish(context, BuyerLayout());
                },
                child: Text(tr('skip'),style:const TextStyle(color: defaultColorTwo),),
            )
        ],
      ),
    ),
  );
}

Future showToast ({required String msg , bool? toastState})
{
 return Fluttertoast.showToast(
   msg: msg,
   toastLength: Toast.LENGTH_LONG,
   gravity: ToastGravity.BOTTOM,
   timeInSecForIosWeb: 5,
   textColor: Colors.white,
   fontSize: 16.0,
   backgroundColor: toastState != null
       ? toastState ?Colors.yellow[900]
       : Colors.red : Colors.green,
 );
}


checkNet(context) {
  if (!isConnect!) {
    navigateAndFinish(context,const NoConnect(),);
  }
}

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
