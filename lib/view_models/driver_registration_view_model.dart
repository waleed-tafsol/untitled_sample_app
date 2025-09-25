import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StepData {
  final String title;
  final String subtitle;
  final IconData icon;

  StepData({required this.title, required this.subtitle, required this.icon});
}

class DriverRegistrationViewModel extends ChangeNotifier {
  final Map<int, GlobalKey<FormState>> _stepFormKeys = {};

  // Stepper state management
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Steps data
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
      title: 'Shift',
      subtitle: 'Set your working hours',
      icon: Iconsax.clock,
    ),
    StepData(
      title: 'Stripe',
      subtitle: 'Connect with Stripe',
      icon: Iconsax.wallet_3,
    ),
  ];





  GlobalKey<FormState> getFormKeyForStep(int step) {
    if (!_stepFormKeys.containsKey(step)) {
      _stepFormKeys[step] = GlobalKey<FormState>();
    }
    return _stepFormKeys[step]!;
  }

  void resetStepFormKey(int step) {
    if (_stepFormKeys.containsKey(step)) {
      _stepFormKeys[step]!.currentState?.reset();
      _stepFormKeys.remove(step);
    }
  }

  bool validateFormKey() {
    // Use the current step's form key for validation
    final currentFormKey = getFormKeyForStep(_currentStep);
    if (currentFormKey.currentState?.validate() == true) {
      return true;
    } else {
      return false;
    }
  }

  // Stepper getters
  int get getCurrentStep => _currentStep;

  PageController get getPageController => _pageController;

  List<StepData> get getSteps => _steps;















  // Stepper navigation methods
  void nextStep() {
    if (_currentStep < 5) {
      // 0-5 steps (6 total)
      _navigateToStep(_currentStep + 1);
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _navigateToStep(_currentStep - 1);
    }
  }

  void setCurrentStep(int step) {
    if (step >= 0 && step <= 5) {
      _navigateToStep(step);
    }
  }

  void _navigateToStep(int step) {
    // Update current step
    _currentStep = step;

    // Navigate to the step
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    notifyListeners();
  }

  bool canGoNext() {
    return _currentStep < 5;
  }

  bool canGoPrevious() {
    return _currentStep > 0;
  }

  bool isLastStep() {
    return _currentStep == 5;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
