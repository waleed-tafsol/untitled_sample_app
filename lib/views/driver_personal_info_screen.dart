import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/custom_font_style.dart';
import 'package:untitled_sample_app/utils/enums.dart';
import 'package:untitled_sample_app/view_models/auth_view_model.dart';
import '../utils/custom_colors.dart';
import '../utils/validators.dart';
import '../view_models/driver_registration_view_model.dart';
import '../widgets/user_form_fields_widget.dart';

class DriverPersonalInfoScreen extends StatefulWidget {
  const DriverPersonalInfoScreen({super.key});

  @override
  State<DriverPersonalInfoScreen> createState() =>
      _DriverPersonalInfoScreenState();
}

class _DriverPersonalInfoScreenState extends State<DriverPersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DriverRegistrationViewModel>(
      builder: (_, driverRegistrationViewModel, _) {
        return Form(
          key: driverRegistrationViewModel.getFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                black24w600(data: 'Personal Information'),
                grey12(data: 'Enter your personal details'),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[9],
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: CustomColors.primaryColor.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Iconsax.user,
                            color: CustomColors.primaryColor,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          black18w500(data: 'Personal Details'),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      grey12(
                        data:
                            'Please provide your personal information to complete registration',
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: driverRegistrationViewModel
                                  .getFirstNameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 14.h,
                                ),
                                prefixIcon: Icon(Iconsax.user),
                                labelText: 'First Name',
                                hintText: 'John',
                              ),
                              validator: validateFirstName,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextFormField(
                              controller: driverRegistrationViewModel
                                  .getFirstNameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 14.h,
                                ),
                                prefixIcon: Icon(Iconsax.user),
                                labelText: 'Last Name',
                                hintText: 'Smith',
                              ),
                              validator: validateFirstName,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      phoneFieldWidget(
                        viewOnly:
                            context.read<AuthViewModel>().getLoginWith ==
                            LoginWith.phone.value,
                      ),
                      SizedBox(height: 20.h),
                      emailFieldWidget(
                        viewOnly:
                            context.read<AuthViewModel>().getLoginWith ==
                            LoginWith.email.value,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    boxShadow: kElevationToShadow[9],
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: CustomColors.primaryColor.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
