import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../utils/custom_colors.dart';
import '../view_models/auth_view_model.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (_, authViewModel, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: authViewModel.getPhoneController,
            onChanged: (text) {
              // Combine country code with phone number
              final fullPhoneNumber = '${authViewModel.getCountryCode}$text';
              authViewModel.updatePhoneNumber(fullPhoneNumber);
            },
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!authViewModel.isPhoneValid) {
                return 'Please enter a valid Australian phone number';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Phone Number',
                prefixIcon: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Iconsax.mobile),
                        CountryCodePicker(
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
                        )
                      ],
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 5.h,
          )
        ],
      );
    });
  }
}
