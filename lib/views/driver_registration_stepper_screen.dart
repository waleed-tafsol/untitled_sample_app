import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final Map<String, dynamic> _stripeInfo = {};
  final Map<String, String> _shiftInfo = {};
  

  final List<StepData> _steps = [
    StepData(
      title: 'Personal Information',
      subtitle: 'Enter your personal details',
      icon: Icons.person,
    ),
    StepData(
      title: 'Documents',
      subtitle: 'Upload required documents',
      icon: Icons.description,
    ),
    StepData(
      title: 'Review',
      subtitle: 'Review your information',
      icon: Icons.rate_review,
    ),
    StepData(
      title: 'Vehicle',
      subtitle: 'Add your vehicle details',
      icon: Icons.directions_car,
    ),
    StepData(
      title: 'Payment',
      subtitle: 'Set up payment method',
      icon: Icons.payment,
    ),
    StepData(
      title: 'Stripe',
      subtitle: 'Connect with Stripe',
      icon: Icons.account_balance_wallet,
    ),
    StepData(
      title: 'Shift',
      subtitle: 'Set your working hours',
      icon: Icons.schedule,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Driver Registration',
          style: TextStyle(
            color: Colors.black,
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
                                    : Colors.grey.shade300,
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
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  _steps[_currentStep].title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _steps[_currentStep].subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
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
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: CustomColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          color: CustomColors.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      if(context.read<DriverRegistrationViewModel>().validateFormKey()) {
                        _currentStep < _steps.length - 1 ? _nextStep : _completeRegistration;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: Text(
                      _currentStep < _steps.length - 1 ? 'Next' : 'Complete',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
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
        title: const Text('Registration Complete!'),
        content: const Text('Your driver registration has been submitted successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to login
            },
            child: const Text('OK'),
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
