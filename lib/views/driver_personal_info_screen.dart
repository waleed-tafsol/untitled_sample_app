import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Header Section
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
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
                          Text(
                            'Personal Details',
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Please provide your personal information to complete registration',
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 14.sp,
                          color: CustomColors.blackColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24.h),
                
                // Form Section
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
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
                      // Name Fields
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              'First Name',
                              'John',
                              driverRegistrationViewModel.getFirstNameController,
                              validator: validateFirstName,
                              icon: Iconsax.user,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildInputField(
                              'Last Name',
                              'Smith',
                              driverRegistrationViewModel.getLastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Last Name is required';
                                }
                                return null;
                              },
                              icon: Iconsax.user,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      
                      // Phone Field
                      phoneFieldWidget(viewOnly: context.read<AuthViewModel>().getLoginWith == LoginWith.phone.value),
                      SizedBox(height: 20.h),
                      
                      // Email Field
                      emailFieldWidget(viewOnly: context.read<AuthViewModel>().getLoginWith == LoginWith.email.value),
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

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller, {
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: CustomColors.blackColor,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
            color: CustomColors.blackColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
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
                color: CustomColors.primaryColor,
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
            prefixIcon: icon != null
                ? Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Icon(
                      icon,
                      color: CustomColors.primaryColor,
                      size: 20.sp,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}