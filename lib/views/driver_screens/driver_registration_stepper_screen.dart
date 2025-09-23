import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_buttons.dart';
import '../../view_models/driver_registration_view_model.dart';
import 'driver_personal_info_screen.dart';
import 'driver_documents_screen.dart';
import 'driver_info_review_screen.dart';
import 'driver_stripe_kyc_screen.dart';
import 'driver_shift_screen.dart';
import 'driver_vehicle_screen.dart';

class RegistrationStepperScreen extends StatelessWidget {
  const RegistrationStepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverRegistrationViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: CustomColors.whiteColor,
          appBar: _buildAppBar(context, viewModel),
          body: Column(
            children: [
              _buildProgressIndicator(viewModel),
              Expanded(child: _buildPageView(viewModel)),
              _buildNavigationButtons(context, viewModel),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, DriverRegistrationViewModel viewModel) {
    return AppBar(
      backgroundColor: CustomColors.whiteColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Iconsax.arrow_left_2, color: CustomColors.blackColor, size: 24.sp),
        onPressed: () => viewModel.getCurrentStep > 0 
            ? viewModel.previousStep() 
            : Navigator.pop(context),
      ),
      title: Text(
        'Driver Registration',
        style: TextStyle(
          fontFamily: 'CircularStd',
          color: CustomColors.blackColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProgressIndicator(DriverRegistrationViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Row(
            children: List.generate(viewModel.getSteps.length, (index) => 
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: index <= viewModel.getCurrentStep
                              ? CustomColors.primaryColor
                              : CustomColors.blackColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    if (index < viewModel.getSteps.length - 1) SizedBox(width: 8.w),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Step ${viewModel.getCurrentStep + 1} of ${viewModel.getSteps.length}',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              color: CustomColors.blackColor.withValues(alpha: 0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(DriverRegistrationViewModel viewModel) {
    return PageView.builder(
      controller: viewModel.getPageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) => viewModel.setCurrentStep(index),
      itemCount: viewModel.getSteps.length,
      itemBuilder: (context, index) => _getStepScreen(index),
    );
  }

  Widget _getStepScreen(int stepIndex) {
    const screens = [
      DriverPersonalInfoScreen(),
      DriverDocumentsScreen(),
      DriverInfoReviewScreen(),
      DriverVehicleScreen(),
      DriverShiftScreen(),
      DriverStripeKycScreen(),
    ];
    return screens[stepIndex];
  }

  Widget _buildNavigationButtons(BuildContext context, DriverRegistrationViewModel viewModel) {
    final isFirstStep = viewModel.getCurrentStep == 0;
    final isLastStep = viewModel.getCurrentStep == viewModel.getSteps.length - 1;
    
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          if (!isFirstStep) ...[
            Expanded(
              child: _buildButton(
                text: 'Previous',
                icon: Iconsax.arrow_left_2,
                isPrimary: false,
                onTap: () => viewModel.previousStep(),
              ),
            ),
            SizedBox(width: 16.w),
          ],
          Expanded(
            child: _buildButton(
              text: isLastStep ? 'Complete' : 'Next',
              icon: isLastStep ? Iconsax.tick_circle : Iconsax.arrow_right_3,
              isPrimary: true,
              onTap: () => _handleNextOrComplete(context, viewModel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: isPrimary ? CustomColors.primaryColor : CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: isPrimary ? null : Border.all(color: CustomColors.primaryColor, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isPrimary ? CustomColors.whiteColor : CustomColors.primaryColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(icon, color: isPrimary ? CustomColors.whiteColor : CustomColors.primaryColor, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNextOrComplete(BuildContext context, DriverRegistrationViewModel viewModel) {
    if (context.read<DriverRegistrationViewModel>().validateFormKey()) {
      if (viewModel.getCurrentStep < viewModel.getSteps.length - 1) {
        viewModel.nextStep();
      } else {
        _showCompletionDialog(context);
      }
    }
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CustomColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            Icon(Iconsax.tick_circle, color: CustomColors.primaryColor, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              'Registration Complete!',
              style: TextStyle(
                fontFamily: 'CircularStd',
                color: CustomColors.blackColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Your driver registration has been submitted successfully.',
          style: TextStyle(
            fontFamily: 'CircularStd',
            color: CustomColors.blackColor.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: customButton(
              text: 'OK',
              onTap: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to login
              },
              colored: true,
            ),
          ),
        ],
      ),
    );
  }
}