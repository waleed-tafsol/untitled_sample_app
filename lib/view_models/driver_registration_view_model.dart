import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:io';

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

class DriverRegistrationViewModel extends ChangeNotifier {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _streetAddressController = TextEditingController();
  final TextEditingController _suburbController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _abnController = TextEditingController();
  final TextEditingController _etagNumberController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licenseExpiryController = TextEditingController();
  final TextEditingController _emergencyContactNameController = TextEditingController();
  final TextEditingController _emergencyContactNumberController = TextEditingController();
  final TextEditingController _emergencyContactEmailController = TextEditingController();
  
  // Vehicle Information Controllers
  final TextEditingController _taxiPlateController = TextEditingController();
  final TextEditingController _operatorNameController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  
  GlobalKey<FormState>? _formKey;
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

  // Image picker and document images
  final ImagePicker _imagePicker = ImagePicker();
  File? _identityVerificationImage;
  final Map<String, File?> _documentImages = {
    'driverLicenseFront': null,
    'driverLicenseBack': null,
    'drivingRecord': null,
    'policeCheck': null,
    'passport': null,
    'vevoDetails': null,
    'englishCertificate': null,
  };
  
  // Vehicle Information State
  String _selectedVehicleType = 'sedan';
  File? _frontPlateImage;
  File? _rearPlateImage;
  final Map<String, File?> _requiredDocuments = {
    'registration': null,
    'comprehensiveInsurance': null,
    'ctpInsurance': null,
  };
  final Map<String, File?> _additionalDocuments = {
    'workCover': null,
    'publicLiability': null,
    'safetyInspection': null,
    'cameraInspection': null,
  };

  TextEditingController get getFirstNameController => _firstNameController;

  TextEditingController get getLastNameController => _lastNameController;

  TextEditingController get getStreetAddressController => _streetAddressController;

  TextEditingController get getSuburbController => _suburbController;

  TextEditingController get getPostcodeController => _postcodeController;

  TextEditingController get getAbnController => _abnController;

  TextEditingController get getEtagNumberController => _etagNumberController;

  TextEditingController get getLicenseNumberController => _licenseNumberController;

  TextEditingController get getLicenseExpiryController => _licenseExpiryController;

  TextEditingController get getEmergencyContactNameController => _emergencyContactNameController;

  TextEditingController get getEmergencyContactNumberController => _emergencyContactNumberController;

  TextEditingController get getEmergencyContactEmailController => _emergencyContactEmailController;
  
  // Vehicle Information Getters
  TextEditingController get getTaxiPlateController => _taxiPlateController;
  TextEditingController get getOperatorNameController => _operatorNameController;
  TextEditingController get getMakeController => _makeController;
  TextEditingController get getModelController => _modelController;
  TextEditingController get getYearController => _yearController;
  TextEditingController get getColorController => _colorController;

  GlobalKey<FormState> get getFormKey {
    if (_formKey == null) {
      _formKey = GlobalKey<FormState>();
    }
    return _formKey!;
  }

  GlobalKey<FormState> getFormKeyForStep(int step) {
    if (!_stepFormKeys.containsKey(step)) {
      _stepFormKeys[step] = GlobalKey<FormState>();
    }
    return _stepFormKeys[step]!;
  }

  void resetFormKey() {
    if (_formKey != null) {
      _formKey!.currentState?.reset();
      _formKey = null;
    }
  }

  void resetStepFormKey(int step) {
    if (_stepFormKeys.containsKey(step)) {
      _stepFormKeys[step]!.currentState?.reset();
      _stepFormKeys.remove(step);
    }
  }

  // Stepper getters
  int get getCurrentStep => _currentStep;
  PageController get getPageController => _pageController;
  List<StepData> get getSteps => _steps;

  // Image and document getters
  File? get getIdentityVerificationImage => _identityVerificationImage;
  
  Map<String, File?> get getDocumentImages => Map.from(_documentImages);
  
  // Vehicle Information State Getters
  String get getSelectedVehicleType => _selectedVehicleType;
  File? get getFrontPlateImage => _frontPlateImage;
  File? get getRearPlateImage => _rearPlateImage;
  Map<String, File?> get getRequiredDocuments => Map.from(_requiredDocuments);
  Map<String, File?> get getAdditionalDocuments => Map.from(_additionalDocuments);
  
  File? getDocumentImage(String documentKey) => _documentImages[documentKey];
  
  bool hasDocumentImage(String documentKey) => _documentImages[documentKey] != null;
  
  bool get hasIdentityVerificationImage => _identityVerificationImage != null;
  
  bool get areAllDocumentsUploaded {
    return _documentImages.values.every((image) => image != null) && 
           _identityVerificationImage != null;
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

  // Image handling methods
  Future<void> captureIdentityImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      
      if (image != null) {
        _identityVerificationImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to capture identity image: $e');
    }
  }

  Future<void> pickDocumentImage(String documentKey, ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );
      
      if (image != null) {
        _documentImages[documentKey] = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to pick document image: $e');
    }
  }

  void removeDocumentImage(String documentKey) {
    _documentImages[documentKey] = null;
    notifyListeners();
  }

  void removeIdentityVerificationImage() {
    _identityVerificationImage = null;
    notifyListeners();
  }

  void clearAllImages() {
    _identityVerificationImage = null;
    _documentImages.updateAll((key, value) => null);
    notifyListeners();
  }

  // Declarations state management
  final Map<String, bool?> _declarations = {
    'qualifiedToOperate': null,
    'consentToAgreement': null,
    'consentToInformationStatement': null,
  };

  // Driver type state management
  String _selectedDriverType = 'fullTime'; // 'fullTime' or 'partTime'

  // Working days and hours state management
  final Set<String> _selectedWorkingDays = {};
  TimeOfDay _preferredStartTime = TimeOfDay(hour: 9, minute: 0);
  int _selectedHours = 8;

  // Driver type getters and setters
  String get getSelectedDriverType => _selectedDriverType;
  bool get isFullTimeDriver => _selectedDriverType == 'fullTime';
  bool get isPartTimeDriver => _selectedDriverType == 'partTime';

  void setDriverType(String driverType) {
    _selectedDriverType = driverType;
    // Reset selections when changing driver type
    _selectedWorkingDays.clear();
    _selectedHours = driverType == 'fullTime' ? 8 : 6;
    notifyListeners();
  }

  // Working days getters and setters
  Set<String> get getSelectedWorkingDays => Set.from(_selectedWorkingDays);
  bool isWorkingDaySelected(String day) => _selectedWorkingDays.contains(day);
  int get getSelectedWorkingDaysCount => _selectedWorkingDays.length;
  bool get isValidWorkingDaysSelection {
    if (isFullTimeDriver) {
      return _selectedWorkingDays.length >= 4;
    } else {
      return _selectedWorkingDays.length <= 3 && _selectedWorkingDays.length > 0;
    }
  }

  void toggleWorkingDay(String day) {
    // Convert full day names to short forms for consistency
    final dayMap = {
      'Monday': 'Mon',
      'Tuesday': 'Tue', 
      'Wednesday': 'Wed',
      'Thursday': 'Thu',
      'Friday': 'Fri',
      'Saturday': 'Sat',
      'Sunday': 'Sun',
    };
    
    final shortDay = dayMap[day] ?? day;
    
    if (_selectedWorkingDays.contains(shortDay)) {
      _selectedWorkingDays.remove(shortDay);
    } else {
      if (isFullTimeDriver) {
        // No limit for full-time
        _selectedWorkingDays.add(shortDay);
      } else {
        // Max 3 days for part-time
        if (_selectedWorkingDays.length < 3) {
          _selectedWorkingDays.add(shortDay);
        }
      }
    }
    notifyListeners();
  }

  // Working hours getters and setters
  TimeOfDay get getPreferredStartTime => _preferredStartTime;
  int get getSelectedHours => _selectedHours;
  int get getMaxHours => isFullTimeDriver ? 12 : 8;
  int get getMinHours => isFullTimeDriver ? 6 : 4;

  void setPreferredStartTime(TimeOfDay time) {
    _preferredStartTime = time;
    notifyListeners();
  }

  void setSelectedHours(int hours) {
    if (hours >= getMinHours && hours <= getMaxHours) {
      _selectedHours = hours;
      notifyListeners();
    }
  }

  // Declaration getters and setters
  bool? getDeclaration(String declarationKey) => _declarations[declarationKey];
  
  bool get isQualifiedToOperate => _declarations['qualifiedToOperate'] ?? false;
  bool get hasConsentedToAgreement => _declarations['consentToAgreement'] ?? false;
  bool get hasConsentedToInformationStatement => _declarations['consentToInformationStatement'] ?? false;
  
  bool get areAllDeclarationsAccepted {
    return _declarations.values.every((value) => value == true);
  }

  void setDeclaration(String declarationKey, bool value) {
    _declarations[declarationKey] = value;
    notifyListeners();
  }
  
  // Vehicle Information Methods
  void setSelectedVehicleType(String type) {
    _selectedVehicleType = type;
    notifyListeners();
  }
  
  Future<void> capturePlateImage(bool isFront) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (image != null) {
        if (isFront) {
          _frontPlateImage = File(image.path);
        } else {
          _rearPlateImage = File(image.path);
        }
        notifyListeners();
      }
    } catch (e) {
      // Handle error - could add error state management here
      print('Failed to capture plate image: $e');
    }
  }
  
  Future<void> pickVehicleDocumentImage(String documentKey, ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        if (_requiredDocuments.containsKey(documentKey)) {
          _requiredDocuments[documentKey] = File(image.path);
        } else {
          _additionalDocuments[documentKey] = File(image.path);
        }
        notifyListeners();
      }
    } catch (e) {
      // Handle error - could add error state management here
      print('Failed to pick document image: $e');
    }
  }
  
  bool hasRequiredDocument(String documentKey) => _requiredDocuments[documentKey] != null;
  bool hasAdditionalDocument(String documentKey) => _additionalDocuments[documentKey] != null;
  bool hasPlateImage(bool isFront) => isFront ? _frontPlateImage != null : _rearPlateImage != null;

  void clearAllDeclarations() {
    _declarations.updateAll((key, value) => null);
    notifyListeners();
  }

  // Stepper navigation methods
  void nextStep() {
    if (_currentStep < 5) { // 0-5 steps (6 total)
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _streetAddressController.dispose();
    _suburbController.dispose();
    _postcodeController.dispose();
    _abnController.dispose();
    _etagNumberController.dispose();
    _licenseNumberController.dispose();
    _licenseExpiryController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactNumberController.dispose();
    _emergencyContactEmailController.dispose();
    _taxiPlateController.dispose();
    _operatorNameController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
