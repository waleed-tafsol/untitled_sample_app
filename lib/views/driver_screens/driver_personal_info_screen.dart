import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../utils/enums.dart';
import '../../utils/validators.dart';
import '../../view_models/auth_view_model.dart';
import '../../view_models/driver_personal_info_view_model.dart';
import '../../widgets/user_form_fields_widget.dart';

class DriverPersonalInfoScreen extends StatelessWidget {
  const DriverPersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverPersonalInfoViewModel>(
      builder: (_, driverPersonalInfoViewModel, _) {
        final authViewModel = context.read<AuthViewModel>();
        return Form(
          key: driverPersonalInfoViewModel.getFormKey,
          child: SingleChildScrollView(
            child: AnimationLimiter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  bottom: 20.h,
                ),
                child: Column(
                  children: [
                    // Header (not animated)
                    black24w600(data: 'Personal Information'),
                    grey12(data: 'Enter your personal details'),
                    SizedBox(height: 20.h),
                    // All Sections in One Column (animated)
                    Column(
                      children: AnimationConfiguration.toStaggeredList(
                        childAnimationBuilder: (widget) => FlipAnimation(
                          duration: Duration(seconds: 1),
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [
                          // Personal Details Section
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[9],
                              color: CustomColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: CustomColors.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
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
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getFirstNameController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
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
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getLastNameController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
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
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[3],
                                    color: CustomColors.whiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                  ),
                                  child: phoneFieldWidget(
                                    viewOnly:
                                        authViewModel.getLoginWith ==
                                        LoginWith.phone.value,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[3],
                                    color: CustomColors.whiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                  ),
                                  child: emailFieldWidget(
                                    viewOnly:
                                        authViewModel.getLoginWith ==
                                        LoginWith.email.value,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Address Details Section
                          SizedBox(height: 24.h),
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[9],
                              color: CustomColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: CustomColors.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.location,
                                      color: CustomColors.primaryColor,
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 12.w),
                                    black18w500(data: 'Address Details'),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                grey12(
                                  data:
                                      'Please provide your address information for verification',
                                ),
                                SizedBox(height: 20.h),

                                // Street Address
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[3],
                                    color: CustomColors.whiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: driverPersonalInfoViewModel
                                        .getStreetAddressController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 14.h,
                                      ),
                                      prefixIcon: Icon(Iconsax.home),
                                      labelText: 'Street Address',
                                      hintText: '123 Main Street',
                                    ),
                                    validator: validateStreetAddress,
                                  ),
                                ),
                                SizedBox(height: 20.h),

                                // Suburb and Postcode Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getSuburbController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(
                                              Iconsax.location,
                                            ),
                                            labelText: 'Suburb',
                                            hintText: 'Sydney',
                                          ),
                                          validator: validateSuburb,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getPostcodeController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(Iconsax.code),
                                            labelText: 'Postcode',
                                            hintText: '2000',
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: validatePostcode,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // License & Registration Section
                          SizedBox(height: 24.h),
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[9],
                              color: CustomColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: CustomColors.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.card,
                                      color: CustomColors.primaryColor,
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 12.w),
                                    black18w500(
                                      data: 'License & Registration',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                grey12(
                                  data:
                                      'Please provide your license and registration details',
                                ),
                                SizedBox(height: 20.h),

                                // ABN and E-tag Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getAbnController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(
                                              Iconsax.building,
                                            ),
                                            labelText: 'ABN',
                                            hintText: '12345678901',
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: validateAbn,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getEtagNumberController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(Iconsax.tag),
                                            labelText: 'E-tag Number',
                                            hintText: 'ET123456',
                                          ),
                                          validator: validateEtagNumber,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),

                                // License Number and Expiry Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getLicenseNumberController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(Iconsax.driving),
                                            labelText: 'License Number',
                                            hintText: '123456789',
                                          ),
                                          validator: validateLicenseNumber,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller:
                                              driverPersonalInfoViewModel
                                                  .getLicenseExpiryController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(
                                              Iconsax.calendar,
                                            ),
                                            labelText: 'License Expiry',
                                            hintText: 'DD/MM/YYYY',
                                            suffixIcon: IconButton(
                                              icon: Icon(Iconsax.calendar_1),
                                              onPressed: () async {
                                                final DateTime?
                                                pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now()
                                                      .add(
                                                        Duration(days: 365),
                                                      ),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now()
                                                      .add(
                                                        Duration(days: 3650),
                                                      ),
                                                  // 10 years from now
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context).copyWith(
                                                        colorScheme: ColorScheme.light(
                                                          primary: CustomColors
                                                              .primaryColor,
                                                          onPrimary:
                                                              CustomColors
                                                                  .whiteColor,
                                                          surface:
                                                              CustomColors
                                                                  .whiteColor,
                                                          onSurface:
                                                              CustomColors
                                                                  .blackColor,
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                );
                                                if (pickedDate != null) {
                                                  final formattedDate =
                                                      "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                                  driverPersonalInfoViewModel
                                                          .getLicenseExpiryController
                                                          .text =
                                                      formattedDate;
                                                }
                                              },
                                            ),
                                          ),
                                          readOnly: true,
                                          validator: validateLicenseExpiry,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Emergency Contact Section
                          SizedBox(height: 24.h),
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[9],
                              color: CustomColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: CustomColors.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.call,
                                      color: CustomColors.primaryColor,
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 12.w),
                                    black18w500(data: 'Emergency Contact'),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                grey12(
                                  data:
                                      'Please provide emergency contact information',
                                ),
                                SizedBox(height: 20.h),

                                // Emergency Contact Name
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[3],
                                    color: CustomColors.whiteColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: driverPersonalInfoViewModel
                                        .getEmergencyContactNameController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 14.h,
                                      ),
                                      prefixIcon: Icon(Iconsax.user),
                                      labelText: 'Contact Name',
                                      hintText: 'John Smith',
                                    ),
                                    validator: validateEmergencyContactName,
                                  ),
                                ),
                                SizedBox(height: 20.h),

                                // Emergency Contact Number and Email Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: driverPersonalInfoViewModel
                                              .getEmergencyContactNumberController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(Iconsax.mobile),
                                            labelText: 'Contact Number',
                                            hintText: '0412 345 678',
                                          ),
                                          keyboardType: TextInputType.phone,
                                          validator:
                                              validateEmergencyContactNumber,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[3],
                                          color: CustomColors.whiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.r),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: driverPersonalInfoViewModel
                                              .getEmergencyContactEmailController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 14.h,
                                                ),
                                            prefixIcon: Icon(Iconsax.sms),
                                            labelText: 'Email',
                                            hintText: 'john@example.com',
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator:
                                              validateEmergencyContactEmail,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
}
