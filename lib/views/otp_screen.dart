import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/custom_colors.dart';
import 'package:untitled_sample_app/utils/enums.dart';
import '../utils/phone_formator.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/otp_view_model.dart';
import '../route_generator.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpViewModel>(
      builder: (context, otpViewModel, child) {
        return Scaffold(
          backgroundColor: CustomColors.whiteColor,
          appBar: AppBar(
            backgroundColor: CustomColors.whiteColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Iconsax.arrow_left_2,
                color: CustomColors.blackColor,
                size: 24.sp,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
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
                        Iconsax.shield_tick,
                        size: 40.sp,
                        color: CustomColors.whiteColor,
                      ),
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // Header Text
                    Text(
                      'Enter Verification Code',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.blackColor,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: 12.h),
                    
                    Text(
                      'We sent a 6-digit code to ${context.read<AuthViewModel>().getLoginWith == LoginWith.phone.value ? formattedPhoneNumber(phoneNumber: otpViewModel.getLoginValue) : otpViewModel.getLoginValue}',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 16.sp,
                        color: CustomColors.blackColor.withValues(alpha: 0.6),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: 50.h),
                    
                    // OTP Input Fields Container
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: CustomColors.primaryColor.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // OTP Input Fields
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return Flexible(
                                child: Container(
                                  width: 40.w,
                                  height: 60.h,
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                    color: otpViewModel.focusNodes[index].hasFocus
                                        ? CustomColors.primaryColor.withValues(alpha: 0.1)
                                        : CustomColors.whiteColor,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: otpViewModel.focusNodes[index].hasFocus
                                          ? CustomColors.primaryColor
                                          : CustomColors.primaryColor.withValues(alpha: 0.2),
                                      width: 2,
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: otpViewModel.otpControllers[index],
                                    focusNode: otpViewModel.focusNodes[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    style: TextStyle(
                                      fontFamily: 'CircularStd',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.blackColor,
                                    ),
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    onChanged: (value) =>
                                        otpViewModel.onOtpChanged(index, value),
                                  ),
                                ),
                              );
                            }),
                          ),
                          
                          SizedBox(height: 30.h),
                          
                          // Timer and Resend
                          if (otpViewModel.otpTimerSeconds > 0)
                            Text(
                              'Resend code in ${otpViewModel.otpTimerSeconds}s',
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                fontSize: 14.sp,
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )
                          else
                            TextButton(
                              onPressed: () async {
                                final success = await otpViewModel.sendOtp();
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'OTP sent successfully',
                                        style: TextStyle(
                                          fontFamily: 'CircularStd',
                                          color: CustomColors.whiteColor,
                                        ),
                                      ),
                                      backgroundColor: CustomColors.primaryColor,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Resend Code',
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  fontSize: 16.sp,
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // Verify Button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: otpViewModel.isOtpValid
                            ? CustomColors.primaryColor
                            : CustomColors.primaryColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: otpViewModel.isOtpValid
                              ? () async {
                                  final success = await otpViewModel.verifyOtp();
                                  if (success) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      registrationStepperRoute,
                                    );
                                  }
                                }
                              : null,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Verify OTP',
                                  style: TextStyle(
                                    fontFamily: 'CircularStd',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.whiteColor,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Iconsax.arrow_right_3,
                                  size: 20.sp,
                                  color: CustomColors.whiteColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // Footer Text
                    Text(
                      'Secure • Fast • Reliable',
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