import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import '../services/firebase_service.dart';
import '../utils/image_genrator.dart';
import '../widgets/image_source_bottom_sheet.dart';
import '../models/requests/driver_documents_request.dart';
import '../models/responses/driver_documents_response.dart';
import '../services/driver_documents_service.dart';
import '../models/base_response_model.dart';

class DriverDocumentsViewModel extends ChangeNotifier {
  final ImageGenerator imageGenerator = ImageGenerator();
  final FirebaseService firebaseService = FirebaseService();

  // Document images storage
  String? _identityVerificationImage;
  final Map<String, String?> _documentImages = {
    'driverLicenseFront': null,
    'driverLicenseBack': null,
    'drivingRecord': null,
    'policeCheck': null,
    'passport': null,
    'vevoDetails': null,
    'englishCertificate': null,
  };

  // Progress tracking for uploads
  double _profileImageProgress = 0.0;

  // Form key management
  GlobalKey<FormState>? _formKey;

  // Getters
  String? get getIdentityVerificationImage => _identityVerificationImage;
  Map<String, String?> get getDocumentImages => Map.from(_documentImages);
  double get getUpLoadingProfileImage => _profileImageProgress;
  GlobalKey<FormState>? get getFormKey => _formKey;

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

  // Progress setter
  set setProfileImageProgress(double value) {
    _profileImageProgress = value;
    notifyListeners();
  }

  // Document image getters and setters
  String? getDocumentImage(String documentKey) => _documentImages[documentKey];

  bool hasDocumentImage(String documentKey) => _documentImages[documentKey] != null;

  bool get hasIdentityVerificationImage => _identityVerificationImage != null;

  bool get areAllDocumentsUploaded {
    return _documentImages.values.every((image) => image != null) &&
        _identityVerificationImage != null;
  }

  // Document management methods
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

  // Setter methods for direct file assignment
  void setIdentityVerificationImage(String image) {
    _identityVerificationImage = image;
    notifyListeners();
  }

  void setDocumentImage(String documentKey, String image) {
    _documentImages[documentKey] = image;
    notifyListeners();
  }

  // Identity verification image capture
  Future<bool> captureIdentityImageWithGenerator(File cameraImage) async {
    try {
      // Start progress tracking
      setProfileImageProgress = 0.0;
      
      // Start upload and track real progress
      final String imageUrl = await firebaseService.upLoadImageFile(
        mFileImage: cameraImage,
        fileName: 'profile_image',
        onProgress: (progress) {
          setProfileImageProgress = progress;
        },
      );
      
      setIdentityVerificationImage(imageUrl);

      EasyLoading.showSuccess(
        'Identity verification image captured successfully!',
      );
      return true;
    } catch (e) {
      setProfileImageProgress = 0.0; // Reset progress on error
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  // Pick document image using ImageGenerator
  Future<void> pickDocumentImageWithGenerator(String documentKey) async {
    try {
      await ImageSourceBottomSheet.show(
        title: 'Select Image Source',
        subtitle: 'Choose how you want to add the image',
        onImageSelected: (source) async {
          try {
            EasyLoading.show(status: 'Capturing image...');

            final CroppedFile croppedFile = await imageGenerator
                .createImageFile(fromCamera: source == ImageSource.camera);

            EasyLoading.show(status: 'Uploading image...');

            final String imageUrl = await firebaseService.upLoadImageFile(
              mFileImage: File(croppedFile.path),
              fileName: '${documentKey}_image',
              onProgress: (progress) {
                setProfileImageProgress = progress;
              },
            );
            setDocumentImage(documentKey, imageUrl);

            EasyLoading.showSuccess('Document uploaded successfully!');
          } catch (e) {
            EasyLoading.showError(e.toString());
          }
        },
      );
    } catch (e) {
      debugPrint('Document pick error: $e');
      throw Exception(
        'Failed to upload document. Please check permissions and try again.',
      );
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

  // Get all document information as a map
  Map<String, dynamic> getDocumentsInfo() {
    return {
      'identityVerificationImage': _identityVerificationImage,
      'documentImages': Map.from(_documentImages),
    };
  }

  // Set document information from a map
  void setDocumentsInfo(Map<String, dynamic> documentsInfo) {
    _identityVerificationImage = documentsInfo['identityVerificationImage'];
    if (documentsInfo['documentImages'] != null) {
      _documentImages.clear();
      _documentImages.addAll(Map<String, String?>.from(documentsInfo['documentImages']));
    }
    notifyListeners();
  }

  // Service instance for API calls
  final DriverDocumentsService _service = DriverDocumentsService();

  // Create DriverDocumentsRequest from current data
  DriverDocumentsRequest createRequest() {
    return DriverDocumentsRequest(
      identityVerificationImage: _identityVerificationImage,
      driverLicenseFront: _documentImages['driverLicenseFront'],
      driverLicenseBack: _documentImages['driverLicenseBack'],
      drivingRecord: _documentImages['drivingRecord'],
      policeCheck: _documentImages['policeCheck'],
      passport: _documentImages['passport'],
      vevoDetails: _documentImages['vevoDetails'],
      englishCertificate: _documentImages['englishCertificate'],
    );
  }

  // Set data from DriverDocumentsRequest
  void setFromRequest(DriverDocumentsRequest request) {
    _identityVerificationImage = request.identityVerificationImage;
    _documentImages['driverLicenseFront'] = request.driverLicenseFront;
    _documentImages['driverLicenseBack'] = request.driverLicenseBack;
    _documentImages['drivingRecord'] = request.drivingRecord;
    _documentImages['policeCheck'] = request.policeCheck;
    _documentImages['passport'] = request.passport;
    _documentImages['vevoDetails'] = request.vevoDetails;
    _documentImages['englishCertificate'] = request.englishCertificate;
    notifyListeners();
  }

  // Submit documents to API
  Future<BaseResponseModel> submitDocuments() async {
    final request = createRequest();
    return await _service.submitDriverDocuments(request);
  }

  // Update documents via API
  Future<BaseResponseModel> updateDocuments(String driverId) async {
    final request = createRequest();
    return await _service.updateDriverDocuments(request, driverId);
  }

  // Load documents from API
  Future<DriverDocumentsResponse> loadDocuments(String driverId) async {
    final response = await _service.getDriverDocuments(driverId);
    
    if (response.isSuccess == true && response.driverDocumentsModel != null) {
      try {
        setFromRequest(DriverDocumentsRequest(
          identityVerificationImage: response.driverDocumentsModel!.identityVerificationImage,
          driverLicenseFront: response.driverDocumentsModel!.driverLicenseFront,
          driverLicenseBack: response.driverDocumentsModel!.driverLicenseBack,
          drivingRecord: response.driverDocumentsModel!.drivingRecord,
          policeCheck: response.driverDocumentsModel!.policeCheck,
          passport: response.driverDocumentsModel!.passport,
          vevoDetails: response.driverDocumentsModel!.vevoDetails,
          englishCertificate: response.driverDocumentsModel!.englishCertificate,
        ));
      } catch (e) {
        // Handle parsing error if needed
      }
    }
    
    return response;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
