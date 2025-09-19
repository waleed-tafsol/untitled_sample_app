import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/view_models/driver_registration_view_model.dart';
import '../utils/custom_colors.dart';
import 'driver_personal_info_screen.dart';
import 'driver_documents_screen.dart';
import 'driver_info_review_screen.dart';
import 'driver_payment_screen.dart';
import 'driver_stripe_kyc_screen.dart';
import 'driver_shift_screen.dart';
import 'driver_vehicle_screen.dart';

class RegistrationStepperScreen extends StatefulWidget {
  const RegistrationStepperScreen({super.key});

  @override
  State<RegistrationStepperScreen> createState() => _RegistrationStepperScreenState();
}

class _RegistrationStepperScreenState extends State<RegistrationStepperScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();
  
  // Data storage for each step
  final Map<String, String> _personalInfo = {};
  final Map<String, bool> _documents = {};
  final Map<String, String> _vehicleInfo = {};
  final Map<String, String> _paymentInfo = {};
  final Map<String, String> _shiftInfo = {};
  

  final List<StepData> _steps = [
    StepData(
      title: 'Personal Information',
      subtitle: 'Enter your personal details',
      icon: Iconsax.user,
    ),
    StepData(
      title: 'Documents',
      subtitle: 'Upload required documents',
      icon: Iconsax.document_text,
    ),
    StepData(
      title: 'Review',
      subtitle: 'Review your information',
      icon: Iconsax.tick_circle,
    ),
    StepData(
      title: 'Vehicle',
      subtitle: 'Add your vehicle details',
      icon: Iconsax.car,
    ),
    StepData(
      title: 'Payment',
      subtitle: 'Set up payment method',
      icon: Iconsax.card,
    ),
    StepData(
      title: 'Stripe',
      subtitle: 'Connect with Stripe',
      icon: Iconsax.wallet_3,
    ),
    StepData(
      title: 'Shift',
      subtitle: 'Set your working hours',
      icon: Iconsax.clock,
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
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // Step indicator
                Row(
                  children: List.generate(_steps.length, (index) {
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: index <= _currentStep
                                    ? CustomColors.primaryColor
                                    : CustomColors.blackColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                          ),
                          if (index < _steps.length - 1)
                            SizedBox(width: 8.w),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20.h),
                // Current step info
                Text(
                  'Step ${_currentStep + 1} of ${_steps.length}',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    color: CustomColors.blackColor.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  _steps[_currentStep].title,
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.blackColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _steps[_currentStep].subtitle,
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    color: CustomColors.blackColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),

          // Content area
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                return _buildStepContent(index);
              },
            ),
          ),

          // Navigation buttons
          Container(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: CustomColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: _previousStep,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.arrow_left_2,
                                  color: CustomColors.primaryColor,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Previous',
                                  style: TextStyle(
                                    fontFamily: 'CircularStd',
                                    color: CustomColors.primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 16.w),
                Expanded(
                  child: Container(
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: (){
                          if(context.read<DriverRegistrationViewModel>().validateFormKey()) {
                            _currentStep < _steps.length - 1 ? _nextStep : _completeRegistration;
                          }
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentStep < _steps.length - 1 ? 'Next' : 'Complete',
                                style: TextStyle(
                                  fontFamily: 'CircularStd',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.whiteColor,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                _currentStep < _steps.length - 1 
                                    ? Iconsax.arrow_right_3 
                                    : Iconsax.tick_circle,
                                color: CustomColors.whiteColor,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return DriverPersonalInfoScreen();
      case 1:
        return DriverDocumentsScreen();
      case 2:
        return DriverInfoReviewScreen(
          personalInfo: _personalInfo,
          documents: _documents,
          vehicleInfo: _vehicleInfo,
          paymentInfo: _paymentInfo,
          shiftInfo: _shiftInfo,
        );
      case 3:
        return DriverVehicleScreen();
      case 4:
        return DriverPaymentScreen();
      case 5:
        return DriverStripeKycScreen();
      case 6:
        return DriverShiftScreen();
      default:
        return const SizedBox();
    }
  }


  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
        _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeRegistration() {
    // Handle registration completion
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
          Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: CustomColors.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                        onTap: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back to login
                        },
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class StepData {
  final String title;
  final String subtitle;
  final IconData icon;

  StepData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}