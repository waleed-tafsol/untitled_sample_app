import 'package:flutter/material.dart';

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
  GlobalKey<FormState>? _formKey;

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

  GlobalKey<FormState> get getFormKey {
    _formKey ??= GlobalKey<FormState>();
    return _formKey!;
  }

  bool validateFormKey() {
    if (_formKey?.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormKey() {
    _formKey = null;
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
