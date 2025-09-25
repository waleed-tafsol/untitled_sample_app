import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled_sample_app/models/responses/driver_personal_info_response.dart';
import '../models/requests/driver_personal_info_request.dart';
import '../services/driver_personal_info_service.dart';
import '../models/base_response_model.dart';

class DriverPersonalInfoViewModel extends ChangeNotifier {
  // Personal Information Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _suburbController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _abnController = TextEditingController();
  final TextEditingController _etagNumberController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _licenseExpiryController =
      TextEditingController();
  final TextEditingController _emergencyContactNameController =
      TextEditingController();
  final TextEditingController _emergencyContactNumberController =
      TextEditingController();
  final TextEditingController _emergencyContactEmailController =
      TextEditingController();

  // Form key management
  GlobalKey<FormState>? _formKey;

  // Getters for controllers
  TextEditingController get getFirstNameController => _firstNameController;

  TextEditingController get getLastNameController => _lastNameController;

  TextEditingController get getStreetAddressController =>
      _streetAddressController;

  TextEditingController get getSuburbController => _suburbController;

  TextEditingController get getPostcodeController => _postcodeController;

  TextEditingController get getAbnController => _abnController;

  TextEditingController get getEtagNumberController => _etagNumberController;

  TextEditingController get getLicenseNumberController =>
      _licenseNumberController;

  TextEditingController get getLicenseExpiryController =>
      _licenseExpiryController;

  TextEditingController get getEmergencyContactNameController =>
      _emergencyContactNameController;

  TextEditingController get getEmergencyContactNumberController =>
      _emergencyContactNumberController;

  TextEditingController get getEmergencyContactEmailController =>
      _emergencyContactEmailController;

  DriverPersonalInfoRequest _driverPersonalInfoRequest =
      DriverPersonalInfoRequest();

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

  DriverPersonalInfoRequest createDriverPersonalInfoRequest() {
    _driverPersonalInfoRequest = DriverPersonalInfoRequest(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      streetAddress: _streetAddressController.text.trim(),
      suburb: _suburbController.text.trim(),
      postcode: _postcodeController.text.trim(),
      abn: _abnController.text.trim(),
      etagNumber: _etagNumberController.text.trim(),
      licenseNumber: _licenseNumberController.text.trim(),
      licenseExpiry: _licenseExpiryController.text.trim(),
      emergencyContactName: _emergencyContactNameController.text.trim(),
      emergencyContactNumber: _emergencyContactNumberController.text.trim(),
      emergencyContactEmail: _emergencyContactEmailController.text.trim(),
    );
    return _driverPersonalInfoRequest;
  }

  final DriverPersonalInfoService _service = DriverPersonalInfoService();

  // Submit personal information to API
  Future<BaseResponseModel> submitPersonalInfo() async {
    final request = createDriverPersonalInfoRequest();
    return await _service.submitDriverPersonalInfo(request);
  }

  // Update personal information via API
  Future<BaseResponseModel> updatePersonalInfo(String driverId) async {
    final request = createDriverPersonalInfoRequest();
    return await _service.updateDriverPersonalInfo(request, driverId);
  }

  // Load personal information from API
  Future <bool> loadPersonalInfo(String driverId) async {
    EasyLoading.show(status: 'Getting personal details');
    try {
      final DriverPersonalInfoResponse response = await _service
          .getDriverPersonalInfo(driverId);
      if(response.isSuccess!){
        return true;
        EasyLoading.dismiss();
      }
      else{
        EasyLoading.showError(response.message!);
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
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
