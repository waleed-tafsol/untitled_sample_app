import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/custom_buttons.dart';
import 'package:untitled_sample_app/utils/enums.dart';
import 'package:untitled_sample_app/view_models/otp_view_model.dart';
import 'package:untitled_sample_app/widgets/user_form_fields_widget.dart';

import '../route_generator.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../view_models/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return Scaffold(
          backgroundColor: CustomColors.whiteColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),

                    // Logo/Icon Section
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Icon(
                        Iconsax.mobile,
                        size: 40.sp,
                        color: CustomColors.whiteColor,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Welcome Text
                    black24w600(data: 'Welcome Back!', centre: true),
                    SizedBox(height: 12.h),
                    grey12(
                      data:
                          'Enter your Australian phone number or email to continue',
                      centre: true,
                    ),
                    SizedBox(height: 50.h),

                    // Login Method Toggle
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: kElevationToShadow[9],
                        border: Border.all(
                          color: CustomColors.primaryColor.withValues(
                            alpha: 0.2,
                          ),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                authViewModel.setLoginWith =
                                    LoginWith.phone.value;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                decoration: BoxDecoration(
                                  color:
                                      authViewModel.getLoginWith ==
                                          LoginWith.phone.value
                                      ? CustomColors.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.mobile,
                                      size: 18.sp,
                                      color:
                                          authViewModel.getLoginWith ==
                                              LoginWith.phone.value
                                          ? CustomColors.whiteColor
                                          : CustomColors.blackColor,
                                    ),
                                    SizedBox(width: 8.w),
                                    blackWhite14w500(
                                      data: 'Phone',
                                      isWhite:
                                          authViewModel.getLoginWith ==
                                          LoginWith.phone.value,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                authViewModel.setLoginWith =
                                    LoginWith.email.value;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                decoration: BoxDecoration(
                                  color:
                                      authViewModel.getLoginWith ==
                                          LoginWith.email.value
                                      ? CustomColors.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.sms,
                                      size: 18.sp,
                                      color:
                                          authViewModel.getLoginWith ==
                                              LoginWith.email.value
                                          ? CustomColors.whiteColor
                                          : CustomColors.blackColor,
                                    ),
                                    SizedBox(width: 8.w),
                                    blackWhite14w500(
                                      data: 'Email',
                                      isWhite:
                                          authViewModel.getLoginWith ==
                                          LoginWith.email.value,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),
                    Container(
                      padding: EdgeInsets.all(24.w),
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
                      child: Form(
                        key: authViewModel.getFormKey,
                        child: Column(
                          children: [
                            // Input Field
                            authViewModel.getLoginWith == LoginWith.phone.value
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: kElevationToShadow[3],
                                      color: CustomColors.whiteColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                    ),
                                    child: phoneFieldWidget(),
                                  )
                                : Container(
                                decoration: BoxDecoration(
                                  boxShadow: kElevationToShadow[3],
                                  color: CustomColors.whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                ),
                                child: emailFieldWidget()),

                            SizedBox(height: 30.h),

                            // Terms and Conditions
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: authViewModel.getIsTermsAccepted,
                                  onChanged: (value) {
                                    authViewModel.setIsTermsAccepted =
                                        value ?? false;
                                  },
                                  activeColor: CustomColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'CircularStd',
                                        fontSize: 13.sp,
                                        color: CustomColors.greyColor,
                                        height: 1.4,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text:
                                              'By continuing, you agree to our ',
                                        ),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                            color: CustomColors.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: CustomColors.primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30.h),

                            // Send OTP Button
                            Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: CustomColors.primaryColor,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: customButton(
                                text: 'Send Otp',
                                onTap: () async {
                                  final navigator = Navigator.of(context);
                                  if (authViewModel.validateFormKey()) {
                                    context
                                        .read<OtpViewModel>()
                                        .setPhoneOrEmail(
                                          phone:
                                              authViewModel.getCountryCode +
                                              authViewModel
                                                  .getPhoneController
                                                  .text,
                                          loginType: authViewModel.getLoginWith,
                                          email: authViewModel
                                              .getEmailController
                                              .text,
                                        );
                                    if (authViewModel.getIsTermsAccepted) {
                                      await context
                                          .read<OtpViewModel>()
                                          .sendOtp()
                                          .then((value) {
                                            if (value) {
                                              navigator.pushNamed(otpRoute);
                                            }
                                          });
                                    } else {
                                      EasyLoading.showError(
                                        'Kindly accept terms and services',
                                      );
                                    }
                                  }
                                },
                                colored: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Version and Build Number
                    Text(
                      version.isNotEmpty && buildNumber.isNotEmpty
                          ? 'Version $version (Build $buildNumber)'
                          : 'Loading...',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 12.sp,
                        color: CustomColors.blackColor.withValues(alpha: 0.5),
                        letterSpacing: 0.5,
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
