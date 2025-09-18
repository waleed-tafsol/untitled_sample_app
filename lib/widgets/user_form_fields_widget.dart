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
        readOnly: viewOnly == true ? true : false,
        controller: authViewModel.getPhoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          return validatePhoneNumber(authViewModel.getCountryCode + value!);
        },
        decoration: InputDecoration(
          hintText: 'Phone Number',
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.mobile),
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
                      color: CustomColors.greyColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: VerticalDivider(
                      color: CustomColors.greyShadeColor,
                      thickness: 1,
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

Widget emailFieldWidget() {
  return Consumer<AuthViewModel>(
    builder: (_, authViewModel, __) {
      return TextFormField(
        controller: authViewModel.getEmailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          return validateEmail(value!);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 13.5.h),
          hintText: 'Email Address',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(Iconsax.sms),
          ),
        ),
      );
    },
  );
}
