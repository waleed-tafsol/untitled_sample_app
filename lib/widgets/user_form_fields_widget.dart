import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/validators.dart';

import '../utils/custom_colors.dart';
import '../view_models/auth_view_model.dart';

Widget phoneFieldWidget({bool? viewOnly}) {
  return Consumer<AuthViewModel>(
    builder: (_, authViewModel, __) {
      return TextFormField(
        readOnly: viewOnly ?? false,
        controller: authViewModel.getPhoneController,
        keyboardType: TextInputType.phone,
        style: TextStyle(
          fontFamily: 'CircularStd',
          fontSize: 16.sp,
          color: CustomColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        validator: (value) {
          return validatePhoneNumber(authViewModel.getCountryCode + value!);
        },
        decoration: InputDecoration(
          hintText: 'Enter your phone number',
          hintStyle: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
            color: CustomColors.blackColor.withValues(alpha: 0.5),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: CustomColors.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: CustomColors.blackColor,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.mobile,
                    color: CustomColors.blackColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  CountryCodePicker(
                    enabled: viewOnly == true ? false : true,
                    padding: EdgeInsets.zero,
                    showFlagMain: false,
                    onChanged: (value) {
                      authViewModel.setCountryCode(value.toString());
                    },
                    initialSelection: authViewModel.getCountryCode,
                    favorite: const ['+61', 'AU'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    textStyle: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 16.sp,
                      color: CustomColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: VerticalDivider(
                      color: CustomColors.blackColor.withValues(alpha: 0.3),
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget emailFieldWidget({bool? viewOnly}) {
  return Consumer<AuthViewModel>(
    builder: (_, authViewModel, __) {
      return TextFormField(
        readOnly: viewOnly ?? false,
        controller: authViewModel.getEmailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          fontFamily: 'CircularStd',
          fontSize: 16.sp,
          color: CustomColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        validator: (value) {
          return validateEmail(value!);
        },
        decoration: InputDecoration(
          hintText: 'Enter your email address',
          hintStyle: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
            color: CustomColors.blackColor.withValues(alpha: 0.5),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: CustomColors.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: CustomColors.blackColor,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.red.shade400,
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          prefixIcon: Padding(
            padding: EdgeInsets.all(16.w),
            child: Icon(
              Iconsax.sms,
              color: CustomColors.blackColor,
              size: 20.sp,
            ),
          ),
        ),
      );
    },
  );
}
