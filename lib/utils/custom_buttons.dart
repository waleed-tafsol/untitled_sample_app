import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_colors.dart';

Widget customButton ({required String text,required VoidCallback onPressed, required bool colored, IconData? icon, double? height, String? boldText}){
  return SizedBox(
    height: height == null? 50.h : height.h,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: colored ? CustomColors.orangeColor : CustomColors.whiteColor,
        shape: const StadiumBorder(side: BorderSide(width: 1.0,color: CustomColors.orangeColor)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null?  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(icon,color: colored ? CustomColors.whiteColor : CustomColors.orangeColor,),
          ) : Container(),
          Text(text,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: colored ? CustomColors.whiteColor : CustomColors.orangeColor,)),
          boldText != null?Text(boldText,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                color: colored ? CustomColors.whiteColor : CustomColors.orangeColor,)):const SizedBox()
        ],
      ),
    ),
  );
}
Widget customSquareButton ({required String text,required VoidCallback onPressed, required bool colored, }){
  return SizedBox(
    height: 40.h,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        elevation: 0,
        backgroundColor: colored ? CustomColors.orangeColor : CustomColors.whiteColor,
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(width: 1.0,color: CustomColors.orangeColor)),
      ),
      onPressed: onPressed,
      child: Text(text,textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: colored ? CustomColors.whiteColor : CustomColors.orangeColor,)),
    ),
  );
}




