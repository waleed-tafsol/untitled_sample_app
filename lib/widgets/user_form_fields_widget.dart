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
        onChanged: (text) {
       /*   final fullPhoneNumber = '${authViewModel.getCountryCode}$text';
          authViewModel.updatePhoneNumber(fullPhoneNumber);*/
        },
        keyboardType: TextInputType.phone,
        validator: (value) {
          return validatePhoneNumber(authViewModel.getCountryCode+value!);
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
