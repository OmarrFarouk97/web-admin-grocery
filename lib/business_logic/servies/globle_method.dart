
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/text_widgets.dart';
class GlobalMethod{

 static navigateTo({required BuildContext ctx, required String routeName }){
    Navigator.pushNamed(ctx  ,routeName);
  }
  static   Future<void>warningDialog({
   required String title,
   required String subTitle,
   required Function fct,
    required BuildContext context,

}) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  width: 20.w,
                  height: 20.h,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 5.w,),
                  Text(title)
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: TextWidget(
                color: Colors.cyan,
                text: 'Cancel',
                textSize: 18.sp,
              ),),
              TextButton(onPressed: () {
                fct();
              }, child: TextWidget(
                color: Colors.red,
                text: 'Ok',
                textSize: 18.sp,
              ),),

            ],
          );
        });
  }
 static   Future<void>errorDialog({

   required String subTitle,

   required BuildContext context,

 }) async {
   showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(

           title: Row(
             children: [
               Image.asset(
                 'assets/images/warning-sign.png',
                 width: 20.w,
                 height: 20.h,
                 fit: BoxFit.fill,
               ),
               SizedBox(width: 5.w,),
               Text('An error occurred')
             ],
           ),
           content: Text(subTitle),
           actions: [
             TextButton(onPressed: () {
               if (Navigator.canPop(context)){
                 Navigator.pop(context);
               }

             }, child: TextWidget(
               color: Colors.cyan,
               text: 'Ok',
               textSize: 18.sp,
             ),),


           ],
         );
       });
 }

}