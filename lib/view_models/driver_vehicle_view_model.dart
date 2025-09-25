import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/requests/driver_vehicle_request.dart';
import '../models/responses/driver_vehicle_response.dart';
import '../services/driver_vehicle_service.dart';
import '../models/base_response_model.dart';

class DriverVehicleViewModel extends ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();

  // Vehicle Information Controllers
  final TextEditingController _taxiPlateController = TextEditingController();
  final TextEditingController _operatorNameController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

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

  // Form key management
  GlobalKey<FormState>? _formKey;

  // Getters for controllers
  TextEditingController get getTaxiPlateController => _taxiPlateController;
  TextEditingController get getOperatorNameController => _operatorNameController;
  TextEditingController get getMakeController => _makeController;
  TextEditingController get getModelController => _modelController;
  TextEditingController get getYearController => _yearController;
  TextEditingController get getColorController => _colorController;

  // Vehicle Information State Getters
  String get getSelectedVehicleType => _selectedVehicleType;
  File? get getFrontPlateImage => _frontPlateImage;
  File? get getRearPlateImage => _rearPlateImage;
  Map<String, File?> get getRequiredDocuments => Map.from(_requiredDocuments);
  Map<String, File?> get getAdditionalDocuments => Map.from(_additionalDocuments);

  // Form key management
  GlobalKey<FormState> getFormKeyForStep(int step) {
    if (_formKey == null) {
      _formKey = GlobalKey<FormState>();
    }
    return _formKey!;
  }

  void resetFormKey() {
    if (_formKey != null) {
      _formKey!.currentState?.reset();
      _formKey = null;
    }
  }

  // Vehicle Information Methods
  void setSelectedVehicleType(String type) {
    _selectedVehicleType = type;
    notifyListeners();
  }

  void setFrontPlateImage(File image) {
    _frontPlateImage = image;
    notifyListeners();
  }

  void setRearPlateImage(File image) {
    _rearPlateImage = image;
    notifyListeners();
  }

  void setVehicleDocumentImage(String documentKey, File image) {
    if (_requiredDocuments.containsKey(documentKey)) {
      _requiredDocuments[documentKey] = image;
    } else if (_additionalDocuments.containsKey(documentKey)) {
      _additionalDocuments[documentKey] = image;
    }
    notifyListeners();
  }

  // Document checking methods
  bool hasRequiredDocument(String documentKey) => _requiredDocuments[documentKey] != null;
  bool hasAdditionalDocument(String documentKey) => _additionalDocuments[documentKey] != null;
  bool hasPlateImage(bool isFront) => isFront ? _frontPlateImage != null : _rearPlateImage != null;

  // Image capture methods
  Future<void> capturePlateImage(bool isFront) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        if (isFront) {
          _frontPlateImage = File(image.path);
        } else {
          _rearPlateImage = File(image.path);
        }
        notifyListeners();
      }
    } catch (e) {
      print('Failed to capture plate image: $e');
    }
  }

  Future<void> pickVehicleDocumentImage(String documentKey, ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (image != null) {
        if (_requiredDocuments.containsKey(documentKey)) {
          _requiredDocuments[documentKey] = File(image.path);
        } else {
          _additionalDocuments[documentKey] = File(image.path);
        }
        notifyListeners();
      }
    } catch (e) {
      print('Failed to pick document image: $e');
    }
  }

  // Form validation
  bool validateForm() {
    if (_formKey?.currentState?.validate() == true) {
      return true;
    } else {
      return false;
    }
  }

  // Get all vehicle information as a map
  Map<String, dynamic> getVehicleInfo() {
    return {
      'taxiPlate': _taxiPlateController.text.trim(),
      'operatorName': _operatorNameController.text.trim(),
      'make': _makeController.text.trim(),
      'model': _modelController.text.trim(),
      'year': _yearController.text.trim(),
      'color': _colorController.text.trim(),
      'selectedVehicleType': _selectedVehicleType,
      'frontPlateImage': _frontPlateImage?.path,
      'rearPlateImage': _rearPlateImage?.path,
      'requiredDocuments': _requiredDocuments.map((key, value) => MapEntry(key, value?.path)),
      'additionalDocuments': _additionalDocuments.map((key, value) => MapEntry(key, value?.path)),
    };
  }

  // Set vehicle information from a map
  void setVehicleInfo(Map<String, dynamic> vehicleInfo) {
    _taxiPlateController.text = vehicleInfo['taxiPlate'] ?? '';
    _operatorNameController.text = vehicleInfo['operatorName'] ?? '';
    _makeController.text = vehicleInfo['make'] ?? '';
    _modelController.text = vehicleInfo['model'] ?? '';
    _yearController.text = vehicleInfo['year'] ?? '';
    _colorController.text = vehicleInfo['color'] ?? '';
    _selectedVehicleType = vehicleInfo['selectedVehicleType'] ?? 'sedan';
    
    if (vehicleInfo['frontPlateImage'] != null && vehicleInfo['frontPlateImage'].isNotEmpty) {
      _frontPlateImage = File(vehicleInfo['frontPlateImage']);
    }
    if (vehicleInfo['rearPlateImage'] != null && vehicleInfo['rearPlateImage'].isNotEmpty) {
      _rearPlateImage = File(vehicleInfo['rearPlateImage']);
    }
    
    if (vehicleInfo['requiredDocuments'] != null) {
      final requiredDocs = Map<String, String>.from(vehicleInfo['requiredDocuments']);
      requiredDocs.forEach((key, value) {
        if (value.isNotEmpty) {
          _requiredDocuments[key] = File(value);
        }
      });
    }
    
    if (vehicleInfo['additionalDocuments'] != null) {
      final additionalDocs = Map<String, String>.from(vehicleInfo['additionalDocuments']);
      additionalDocs.forEach((key, value) {
        if (value.isNotEmpty) {
          _additionalDocuments[key] = File(value);
        }
      });
    }
    
    notifyListeners();
  }

  // Check if all required fields are filled
  bool get isFormComplete {
    final vehicleInfo = getVehicleInfo();
    return vehicleInfo['taxiPlate'].isNotEmpty &&
           vehicleInfo['operatorName'].isNotEmpty &&
           vehicleInfo['make'].isNotEmpty &&
           vehicleInfo['model'].isNotEmpty &&
           vehicleInfo['year'].isNotEmpty &&
           vehicleInfo['color'].isNotEmpty;
  }

  // Clear all controllers and images
  void clearAllData() {
    _taxiPlateController.clear();
    _operatorNameController.clear();
    _makeController.clear();
    _modelController.clear();
    _yearController.clear();
    _colorController.clear();
    _selectedVehicleType = 'sedan';
    _frontPlateImage = null;
    _rearPlateImage = null;
    _requiredDocuments.updateAll((key, value) => null);
    _additionalDocuments.updateAll((key, value) => null);
    notifyListeners();
  }

  // Service instance for API calls
  final DriverVehicleService _service = DriverVehicleService();

  // Create DriverVehicleRequest from current data
  DriverVehicleRequest createRequest() {
    return DriverVehicleRequest(
      taxiPlate: _taxiPlateController.text.trim(),
      operatorName: _operatorNameController.text.trim(),
      make: _makeController.text.trim(),
      model: _modelController.text.trim(),
      year: _yearController.text.trim(),
      color: _colorController.text.trim(),
      selectedVehicleType: _selectedVehicleType,
      frontPlateImage: _frontPlateImage?.path,
      rearPlateImage: _rearPlateImage?.path,
      requiredDocuments: _requiredDocuments.map((key, value) => MapEntry(key, value?.path)),
      additionalDocuments: _additionalDocuments.map((key, value) => MapEntry(key, value?.path)),
    );
  }

  // Set data from DriverVehicleRequest
  void setFromRequest(DriverVehicleRequest request) {
    _taxiPlateController.text = request.taxiPlate ?? '';
    _operatorNameController.text = request.operatorName ?? '';
    _makeController.text = request.make ?? '';
    _modelController.text = request.model ?? '';
    _yearController.text = request.year ?? '';
    _colorController.text = request.color ?? '';
    _selectedVehicleType = request.selectedVehicleType ?? 'sedan';
    
    if (request.frontPlateImage != null && request.frontPlateImage!.isNotEmpty) {
      _frontPlateImage = File(request.frontPlateImage!);
    }
    if (request.rearPlateImage != null && request.rearPlateImage!.isNotEmpty) {
      _rearPlateImage = File(request.rearPlateImage!);
    }
    
    if (request.requiredDocuments != null) {
      request.requiredDocuments!.forEach((key, value) {
        if (value != null && value.isNotEmpty) {
          _requiredDocuments[key] = File(value);
        }
      });
    }
    
    if (request.additionalDocuments != null) {
      request.additionalDocuments!.forEach((key, value) {
        if (value != null && value.isNotEmpty) {
          _additionalDocuments[key] = File(value);
        }
      });
    }
    
    notifyListeners();
  }

  // Submit vehicle information to API
  Future<BaseResponseModel> submitVehicleInfo() async {
    final request = createRequest();
    return await _service.submitDriverVehicle(request);
  }

  // Update vehicle information via API
  Future<BaseResponseModel> updateVehicleInfo(String driverId) async {
    final request = createRequest();
    return await _service.updateDriverVehicle(request, driverId);
  }

  // Load vehicle information from API
  Future<DriverVehicleResponse> loadVehicleInfo(String driverId) async {
    final response = await _service.getDriverVehicle(driverId);
    
    if (response.isSuccess == true && response.driverVehicleModel != null) {
      try {
        setFromRequest(DriverVehicleRequest(
          taxiPlate: response.driverVehicleModel!.taxiPlate,
          operatorName: response.driverVehicleModel!.operatorName,
          make: response.driverVehicleModel!.make,
          model: response.driverVehicleModel!.model,
          year: response.driverVehicleModel!.year,
          color: response.driverVehicleModel!.color,
          selectedVehicleType: response.driverVehicleModel!.selectedVehicleType,
          frontPlateImage: response.driverVehicleModel!.frontPlateImage,
          rearPlateImage: response.driverVehicleModel!.rearPlateImage,
          requiredDocuments: response.driverVehicleModel!.requiredDocuments,
          additionalDocuments: response.driverVehicleModel!.additionalDocuments,
        ));
      } catch (e) {
        // Handle parsing error if needed
      }
    }
    
    return response;
  }

  @override
  void dispose() {
    _taxiPlateController.dispose();
    _operatorNameController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    super.dispose();
  }
}
