import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled_sample_app/app_init.dart';

import 'custom_colors.dart';

Widget customButton(
    {required String text, required VoidCallback onTap, required bool colored, IconData? icon, double? height, String? boldText}) {
  return SizedBox(
    height: height == null ? 50.h : height.h,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colored ? CustomColors.purpleColor : CustomColors
              .whiteColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(width: 1.0,color: CustomColors.
              purpleColor)),
    ),
    onPressed: (){
      FocusScope.of(navigatorKey.currentContext!).unfocus();
      onTap();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Icon(icon,
            color: colored ? CustomColors.whiteColor : CustomColors
                .purpleColor,),
        ) : Container(),
        Text(text,
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: colored ? CustomColors.whiteColor : CustomColors
                  .purpleColor,)),
        boldText != null ? Text(boldText,
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              fontWeight: FontWeight.w900,
              color: colored ? CustomColors.whiteColor : CustomColors
                  .purpleColor,)) : const SizedBox()
      ],
    ),
  ),);
}





