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
        validator: (value) {
          return validatePhoneNumber(authViewModel.getCountryCode + value!);
        },
        decoration: InputDecoration(
          hintText: 'Enter your phone number',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Iconsax.mobile,
                    color: CustomColors.blackColor,
                    size: 20.sp,
                  ),
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
                      fontSize: 14.sp,
                      color: CustomColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
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
        validator: (value) {
          return validateEmail(value!);
        },
        decoration: InputDecoration(
          hintText: 'Enter your email address',
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.5.h),
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
