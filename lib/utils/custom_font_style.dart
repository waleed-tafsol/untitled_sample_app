import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_colors.dart';

Widget black14w500({required String data, bool? centre}) {
  return Text(
    textAlign: centre != null && centre == true
        ? TextAlign.center
        : TextAlign.left,
    data,
    style: TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 14.sp,
      color: CustomColors.blackColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget black18w500({required String data, bool? centre}) {
  return Text(
    textAlign: centre != null && centre == true
        ? TextAlign.center
        : TextAlign.left,
    data,
    style: TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 18.sp,
      color: CustomColors.blackColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget black24w600({required String data, bool? centre}) {
  return Text(
    textAlign: centre != null && centre == true
        ? TextAlign.center
        : TextAlign.left,
    data,
    style: TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 25.sp,
      color: CustomColors.blackColor,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget primary14w500({required String data, bool? centre}) {
  return Text(
    textAlign: centre != null && centre == true
        ? TextAlign.center
        : TextAlign.left,
    data,
    style: TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 14.sp,
      color: CustomColors.primaryColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget blackWhite14w500({
  required String data,
  bool? centre,
  required bool isWhite,
}) {
  return Text(
    textAlign: centre != null && centre == true
        ? TextAlign.center
        : TextAlign.left,
    data,
    style: TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 14.sp,
      color: isWhite ? CustomColors.whiteColor : CustomColors.blackColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget grey14({required String data, bool? centre}) {
  return Text(
    textAlign: centre != null && centre == true
        ? TextAlign.center
        : TextAlign.left,
    data,
    style: TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 14.sp,
      color: CustomColors.greyColor,
    ),
  );
}
