import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_buttons.dart';
import '../../view_models/driver_documents_view_model.dart';
import '../../view_models/driver_stepper_view_model.dart';
import '../../view_models/driver_personal_info_view_model.dart';
import '../../view_models/driver_shift_view_model.dart';
import '../../view_models/driver_vehicle_view_model.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'driver_personal_info_screen.dart';
import 'driver_documents_screen.dart';
import 'driver_info_review_screen.dart';
import 'driver_stripe_kyc_screen.dart';
import 'driver_shift_screen.dart';
import 'driver_vehicle_screen.dart';

class DriverStepperScreen extends StatelessWidget {
  const DriverStepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DriverStepperViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DriverPersonalInfoViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => DriverDocumentsViewModel()),
        ChangeNotifierProvider(create: (context) => DriverVehicleViewModel()),
        ChangeNotifierProvider(create: (context) => DriverShiftViewModel()),
      ],
      child: Consumer<DriverStepperViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: CustomColors.whiteColor,
            appBar: CustomAppBarWidget(
              title: 'Driver Registration',
              onBackPressed: () {
                viewModel.getCurrentStep > 0
                    ? viewModel.previousStep()
                    : Navigator.pop(context);
              },
            ),
            body: Column(
              children: [
                _buildProgressIndicator(viewModel),
                Expanded(child: _buildPageView(viewModel)),
                _buildNavigationButtons(context, viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator(DriverStepperViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Row(
            children: List.generate(
              viewModel.getSteps.length,
              (index) => Expanded(
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
                    if (index < viewModel.getSteps.length - 1)
                      SizedBox(width: 8.w),
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

  Widget _buildPageView(DriverStepperViewModel viewModel) {
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

  Widget _buildNavigationButtons(
    BuildContext context,
    DriverStepperViewModel viewModel,
  ) {
    final isFirstStep = viewModel.getCurrentStep == 0;
    final isLastStep =
        viewModel.getCurrentStep == viewModel.getSteps.length - 1;

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
        border: isPrimary
            ? null
            : Border.all(color: CustomColors.primaryColor, width: 1.5),
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
                    color: isPrimary
                        ? CustomColors.whiteColor
                        : CustomColors.primaryColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  icon,
                  color: isPrimary
                      ? CustomColors.whiteColor
                      : CustomColors.primaryColor,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNextOrComplete(
    BuildContext context,
    DriverStepperViewModel viewModel,
  ) {
    // Validate the current step's form
    bool isValid = _validateCurrentStep(context, viewModel.getCurrentStep);

    if (isValid) {
      if (viewModel.getCurrentStep < viewModel.getSteps.length - 1) {
        viewModel.nextStep();
      } else {
        _showCompletionDialog(context);
      }
    }
  }

  bool _validateCurrentStep(BuildContext context, int currentStep) {
    switch (currentStep) {
      case 0: // DriverPersonalInfoScreen
        final personalInfoViewModel = context
            .read<DriverPersonalInfoViewModel>();
        return personalInfoViewModel.validateForm();
      case 1: // DriverDocumentsScreen
        // Documents screen - allow proceeding without validation
        // Users can upload documents at any time during the process
        return true;
      case 2: // DriverInfoReviewScreen
        // Review screen doesn't need validation
        return true;
      case 3: // DriverVehicleScreen
        // Vehicle screen - allow proceeding without strict validation
        // Users can complete vehicle information later
        return true;
      case 4: // DriverShiftScreen
        // Shift screen - allow proceeding without strict validation
        // Users can complete shift preferences and declarations later
        return true;
      case 5: // DriverStripeKycScreen
        // Stripe screen validation would go here
        return true;
      default:
        return true;
    }
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CustomColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Icon(
              Iconsax.tick_circle,
              color: CustomColors.primaryColor,
              size: 24.sp,
            ),
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
