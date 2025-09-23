import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_font_style.dart';
import '../../view_models/driver_registration_view_model.dart';
import 'driver_personal_info_screen.dart';
import 'driver_documents_screen.dart';
import 'driver_info_review_screen.dart';
import 'driver_stripe_kyc_screen.dart';
import 'driver_shift_screen.dart';
import 'driver_vehicle_screen.dart';

class RegistrationStepperScreen extends StatelessWidget {
  const RegistrationStepperScreen({super.key});

  static final List<StepData> _steps = [
    StepData(
      title: 'Personal Information',
      subtitle: 'Enter your personal details',
      icon: Iconsax.user,
      stepIndex: 0,
    ),
    StepData(
      title: 'Documents',
      subtitle: 'Upload required documents',
      icon: Iconsax.document_text,
      stepIndex: 1,
    ),
    StepData(
      title: 'Vehicle',
      subtitle: 'Add your vehicle details',
      icon: Iconsax.car,
      stepIndex: 2,
    ),
    StepData(
      title: 'Shift',
      subtitle: 'Set your working hours',
      icon: Iconsax.clock,
      stepIndex: 3,
    ),
    StepData(
      title: 'Review',
      subtitle: 'Review your information',
      icon: Iconsax.tick_circle,
      stepIndex: 4,
    ),
    StepData(
      title: 'Stripe',
      subtitle: 'Connect with Stripe',
      icon: Iconsax.wallet_3,
      stepIndex: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        title: black18w500(data: 'Driver Registration'),
        centerTitle: true,
      ),
      body: Consumer<DriverRegistrationViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              // Progress indicator
              _buildProgressIndicator(viewModel),
              
              // Content area
              Expanded(
                child: PageView.builder(
                  controller: viewModel.getPageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    viewModel.setCurrentStep(index);
                  },
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    return _buildStepContent(index);
                  },
                ),
              ),
              
              // Navigation buttons
              _buildNavigationButtons(context, viewModel),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator(DriverRegistrationViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Row(
            children: List.generate(_steps.length, (index) => Expanded(
              child: Row(children: [
                Expanded(child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: index <= viewModel.getCurrentStep ? CustomColors.primaryColor : CustomColors.blackColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                )),
                if (index < _steps.length - 1) SizedBox(width: 8.w),
              ]),
            )),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              black14w500(data: 'Step ${viewModel.getCurrentStep + 1} of ${_steps.length}'),
              grey12(data: _steps[viewModel.getCurrentStep].title),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, DriverRegistrationViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(children: [
        if (viewModel.canGoPrevious()) ...[
          Expanded(child: customButton(onTap: viewModel.previousStep, text: 'Previous', colored: false)),
          SizedBox(width: 16.w),
        ],
        Expanded(child: customButton(
          onTap: () => _validateCurrentStep(viewModel) 
            ? (viewModel.canGoNext() ? viewModel.nextStep() : _completeRegistration(context))
            : null,
          text: viewModel.isLastStep() ? 'Complete' : 'Next',
          colored: true,
        )),
      ]),
    );
  }

  Widget _buildStepContent(int stepIndex) {
    const screens = [
      DriverPersonalInfoScreen(),
      DriverDocumentsScreen(),
      DriverVehicleScreen(),
      DriverShiftScreen(),
      DriverInfoReviewScreen(),
      DriverStripeKycScreen(),
    ];
    return screens[stepIndex];
  }

  bool _validateCurrentStep(DriverRegistrationViewModel viewModel) {
    switch (viewModel.getCurrentStep) {
      case 0: return viewModel.validateFormKey();
      case 1: return viewModel.areAllDocumentsUploaded;
      case 2: return true;
      case 3: return viewModel.isValidWorkingDaysSelection;
      case 4: return true;
      case 5: return true;
      default: return false;
    }
  }

  void _completeRegistration(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CustomColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(children: [
          Icon(Iconsax.tick_circle, color: CustomColors.primaryColor, size: 24.sp),
          SizedBox(width: 8.w),
          black18w500(data: 'Registration Complete!'),
        ]),
        content: grey12(data: 'Your driver registration has been submitted successfully.'),
        actions: [SizedBox(
          width: double.infinity,
          child: customButton(
            onTap: () { Navigator.pop(context); Navigator.pop(context); },
            text: 'OK',
            colored: true,
          ),
        )],
      ),
    );
  }

}

class StepData {
  final String title;
  final String subtitle;
  final IconData icon;
  final int stepIndex;

  StepData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.stepIndex,
  });
}