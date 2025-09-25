import 'package:flutter/material.dart';

class DriverPersonalInfoViewModel extends ChangeNotifier {
  // Personal Information Controllers
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

  // Form key management
  GlobalKey<FormState>? _formKey;

  // Getters for controllers
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

  // Form key getter
  GlobalKey<FormState> get getFormKey {
    if (_formKey == null) {
      _formKey = GlobalKey<FormState>();
    }
    return _formKey!;
  }

  // Form validation
  bool validateForm() {
    if (_formKey?.currentState?.validate() == true) {
      return true;
    } else {
      return false;
    }
  }

  // Reset form
  void resetForm() {
    if (_formKey != null) {
      _formKey!.currentState?.reset();
      _formKey = null;
    }
  }

  // Clear all controllers
  void clearAllControllers() {
    _firstNameController.clear();
    _lastNameController.clear();
    _streetAddressController.clear();
    _suburbController.clear();
    _postcodeController.clear();
    _abnController.clear();
    _etagNumberController.clear();
    _licenseNumberController.clear();
    _licenseExpiryController.clear();
    _emergencyContactNameController.clear();
    _emergencyContactNumberController.clear();
    _emergencyContactEmailController.clear();
    notifyListeners();
  }

  // Get all personal information as a map
  Map<String, String> getPersonalInfo() {
    return {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'streetAddress': _streetAddressController.text.trim(),
      'suburb': _suburbController.text.trim(),
      'postcode': _postcodeController.text.trim(),
      'abn': _abnController.text.trim(),
      'etagNumber': _etagNumberController.text.trim(),
      'licenseNumber': _licenseNumberController.text.trim(),
      'licenseExpiry': _licenseExpiryController.text.trim(),
      'emergencyContactName': _emergencyContactNameController.text.trim(),
      'emergencyContactNumber': _emergencyContactNumberController.text.trim(),
      'emergencyContactEmail': _emergencyContactEmailController.text.trim(),
    };
  }

  // Set personal information from a map
  void setPersonalInfo(Map<String, String> personalInfo) {
    _firstNameController.text = personalInfo['firstName'] ?? '';
    _lastNameController.text = personalInfo['lastName'] ?? '';
    _streetAddressController.text = personalInfo['streetAddress'] ?? '';
    _suburbController.text = personalInfo['suburb'] ?? '';
    _postcodeController.text = personalInfo['postcode'] ?? '';
    _abnController.text = personalInfo['abn'] ?? '';
    _etagNumberController.text = personalInfo['etagNumber'] ?? '';
    _licenseNumberController.text = personalInfo['licenseNumber'] ?? '';
    _licenseExpiryController.text = personalInfo['licenseExpiry'] ?? '';
    _emergencyContactNameController.text = personalInfo['emergencyContactName'] ?? '';
    _emergencyContactNumberController.text = personalInfo['emergencyContactNumber'] ?? '';
    _emergencyContactEmailController.text = personalInfo['emergencyContactEmail'] ?? '';
    notifyListeners();
  }

  // Check if all required fields are filled
  bool get isFormComplete {
    final personalInfo = getPersonalInfo();
    return personalInfo.values.every((value) => value.isNotEmpty);
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
    super.dispose();
  }
}
