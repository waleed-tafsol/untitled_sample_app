import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../utils/custom_colors.dart';
import '../view_models/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Car Icon
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Iconsax.car,
                    size: 60.sp,
                    color: CustomColors.primaryColor,
                  ),
                ),

                SizedBox(height: 40.h),

                // App Name
                Text(
                  'DriveApp',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.whiteColor,
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: 20.h),

                // Version and Build Number
                Text(
                  authViewModel.getVersion.isNotEmpty && authViewModel.getBuildNumber.isNotEmpty
                      ? 'Version ${authViewModel.getVersion} (Build ${authViewModel.getBuildNumber})'
                      : 'Loading...',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 16.sp,
                    color: CustomColors.whiteColor.withValues(alpha: 0.8),
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: 60.h),

                // Loading Indicator
                SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.whiteColor.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
