import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/enums.dart';
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
                    black24w600(data: 'Enter Verification Code', centre: true),

                    SizedBox(height: 12.h),

                    grey12(
                      data:
                          'We sent a 6-digit code to ${context.read<AuthViewModel>().getLoginWith == LoginWith.phone.value ? formattedPhoneNumber(phoneNumber: otpViewModel.getLoginValue) : otpViewModel.getLoginValue}',
                      centre: true,
                    ),

                    SizedBox(height: 50.h),

                    // OTP Input Fields Container
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
                        children: [
                          // OTP Input Fields
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return Flexible(
                                child: Container(
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[3],
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        otpViewModel.otpControllers[index],
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
                                      contentPadding: EdgeInsets.all(5),
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
                            primary14w500(
                              data:
                                  'Resend code in ${otpViewModel.otpTimerSeconds}s',
                              centre: true,
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
                                      backgroundColor:
                                          CustomColors.primaryColor,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: primary14w500(
                                data: 'Resend Code',
                                centre: false,
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Verify Button
                    customButton(
                      text: 'Verify OTP',
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
                          : () {},
                      colored: otpViewModel.isOtpValid,
                      icon: Iconsax.arrow_right_3,
                      height: 56,
                    ),

                    SizedBox(height: 40.h),

                    // Footer Text
                    grey12(data: 'Secure • Fast • Reliable', centre: true),
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
