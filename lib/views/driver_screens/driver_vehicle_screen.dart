import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../utils/custom_colors.dart';
import '../../../utils/custom_font_style.dart';

class DriverVehicleScreen extends StatefulWidget {
  const DriverVehicleScreen({super.key});

  @override
  State<DriverVehicleScreen> createState() => _DriverVehicleScreenState();
}

class _DriverVehicleScreenState extends State<DriverVehicleScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  
  // Vehicle Information Controllers
  final _taxiPlateController = TextEditingController();
  final _operatorNameController = TextEditingController();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  String _selectedVehicleType = 'sedan';
  
  // License Plate Images
  File? _frontPlateImage;
  File? _rearPlateImage;
  
  // Required Documents Images
  final Map<String, File?> _requiredDocuments = {
    'registration': null,
    'comprehensiveInsurance': null,
    'ctpInsurance': null,
  };
  
  // Additional Documents Images
  final Map<String, File?> _additionalDocuments = {
    'workCover': null,
    'publicLiability': null,
    'safetyInspection': null,
    'cameraInspection': null,
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
          child: Column(
            children: [
              black24w600(data: 'Vehicle Information'),
              grey12(data: 'Complete your vehicle details and documents'),
              SizedBox(height: 20.h),
              
              // Section 1: Vehicle Information
              _buildVehicleInformationSection(),
              SizedBox(height: 24.h),
              
              // Section 2: License Plate Recognition
              _buildLicensePlateSection(),
              SizedBox(height: 24.h),
              
              // Section 3: Required Documents
              _buildRequiredDocumentsSection(),
              SizedBox(height: 24.h),
              
              // Section 4: Additional Documents
              _buildAdditionalDocumentsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Section 1: Vehicle Information
  Widget _buildVehicleInformationSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.car,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Vehicle Information'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Enter your vehicle details',
          ),
          SizedBox(height: 20.h),
          
          // Taxi Plate Number and Operator Name
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  'Taxi Plate Number',
                  'e.g., TAXI-123',
                  _taxiPlateController,
                  icon: Iconsax.card,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInputField(
                  'Operator Name',
                  'e.g., John Smith',
                  _operatorNameController,
                  icon: Iconsax.user,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Make and Model
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  'Make',
                  'e.g., Toyota',
                  _makeController,
                  icon: Iconsax.car,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInputField(
                  'Model',
                  'e.g., Camry',
                  _modelController,
                  icon: Iconsax.car,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Year and Color
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  'Year',
                  'e.g., 2020',
                  _yearController,
                  keyboardType: TextInputType.number,
                  icon: Iconsax.calendar,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInputField(
                  'Color',
                  'e.g., White',
                  _colorController,
                  icon: Iconsax.colorfilter,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Vehicle Type Selection
          _buildVehicleTypeSelection(),
        ],
      ),
    );
  }

  // Section 2: License Plate Recognition
  Widget _buildLicensePlateSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.scan,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'License Plate Recognition'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Capture front and rear number plate images',
          ),
          SizedBox(height: 20.h),
          
          // Front Plate
          _buildPlateCapture('Front Number Plate', _frontPlateImage, () => _capturePlateImage(true)),
          SizedBox(height: 16.h),
          
          // Rear Plate
          _buildPlateCapture('Rear Number Plate', _rearPlateImage, () => _capturePlateImage(false)),
        ],
      ),
    );
  }

  // Section 3: Required Documents
  Widget _buildRequiredDocumentsSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.document_text,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Required Documents'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Upload required vehicle documents',
          ),
          SizedBox(height: 20.h),
          
          _buildDocumentItem('Registration', 'registration', Iconsax.document),
          SizedBox(height: 16.h),
          _buildDocumentItem('Comprehensive Insurance', 'comprehensiveInsurance', Iconsax.shield_tick),
          SizedBox(height: 16.h),
          _buildDocumentItem('CTP Insurance', 'ctpInsurance', Iconsax.shield_tick),
        ],
      ),
    );
  }

  // Section 4: Additional Documents
  Widget _buildAdditionalDocumentsSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.folder,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Additional Documents'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Upload additional required documents',
          ),
          SizedBox(height: 20.h),
          
          _buildDocumentItem('Work Cover', 'workCover', Iconsax.verify),
          SizedBox(height: 16.h),
          _buildDocumentItem('Public Liability', 'publicLiability', Iconsax.shield_tick),
          SizedBox(height: 16.h),
          _buildDocumentItem('Safety Inspection', 'safetyInspection', Iconsax.scan),
          SizedBox(height: 16.h),
          _buildDocumentItem('Camera Inspection', 'cameraInspection', Iconsax.camera),
        ],
      ),
    );
  }

  // Helper Methods
  Widget _buildInputField(String label, String hint, TextEditingController controller, {TextInputType? keyboardType, IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[3],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
          prefixIcon: Icon(icon),
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildVehicleTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        black14w500(data: 'Vehicle Type'),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildVehicleTypeOption('Sedan', Iconsax.car, 'sedan')),
            SizedBox(width: 8.w),
            Expanded(child: _buildVehicleTypeOption('SUV', Iconsax.car, 'suv')),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(child: _buildVehicleTypeOption('Hatchback', Iconsax.car, 'hatchback')),
            SizedBox(width: 8.w),
            Expanded(child: _buildVehicleTypeOption('Van', Iconsax.truck, 'van')),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleTypeOption(String title, IconData icon, String value) {
    final isSelected = _selectedVehicleType == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedVehicleType = value),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.primaryColor.withValues(alpha: 0.1) : CustomColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? CustomColors.primaryColor : CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? CustomColors.primaryColor : CustomColors.blackColor.withValues(alpha: 0.6), size: 24.w),
            SizedBox(height: 4.h),
            black14w500(data: title),
          ],
        ),
      ),
    );
  }

  Widget _buildPlateCapture(String title, File? image, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        black14w500(data: title),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 120.h,
            decoration: BoxDecoration(
              color: image != null ? Colors.transparent : CustomColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(image, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.camera, size: 32.sp, color: CustomColors.primaryColor.withValues(alpha: 0.6)),
                      SizedBox(height: 8.h),
                      grey12(data: 'Tap to capture', centre: true),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem(String title, String documentKey, IconData icon) {
    final hasImage = _requiredDocuments[documentKey] != null || _additionalDocuments[documentKey] != null;
    return GestureDetector(
      onTap: () => _showImageSourceBottomSheet(documentKey),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[3],
          color: CustomColors.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: hasImage ? CustomColors.primaryColor : CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: hasImage ? CustomColors.primaryColor : CustomColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                hasImage ? Iconsax.tick_circle : icon,
                color: hasImage ? CustomColors.whiteColor : CustomColors.primaryColor,
                size: 24.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  black14w500(data: title),
                  SizedBox(height: 4.h),
                  grey12(data: hasImage ? 'Document uploaded' : 'Tap to upload'),
                ],
              ),
            ),
            Icon(
              hasImage ? Iconsax.tick_circle : Iconsax.arrow_right_3,
              color: hasImage ? CustomColors.primaryColor : CustomColors.blackColor.withValues(alpha: 0.4),
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }

  // Image Capture Methods
  Future<void> _capturePlateImage(bool isFront) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (image != null) {
        setState(() {
          if (isFront) {
            _frontPlateImage = File(image.path);
          } else {
            _rearPlateImage = File(image.path);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${isFront ? 'Front' : 'Rear'} plate image captured!'),
            backgroundColor: CustomColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to capture image: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
      );
    }
  }

  void _showImageSourceBottomSheet(String documentKey) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: CustomColors.whiteColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: CustomColors.primaryColor.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2.r))),
            SizedBox(height: 20.h),
            black18w500(data: 'Select Image Source'),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(child: _buildSourceOption('Camera', Iconsax.camera, () { Navigator.pop(context); _pickImage(documentKey, ImageSource.camera); })),
                SizedBox(width: 16.w),
                Expanded(child: _buildSourceOption('Gallery', Iconsax.gallery, () { Navigator.pop(context); _pickImage(documentKey, ImageSource.gallery); })),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: CustomColors.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: CustomColors.primaryColor.withValues(alpha: 0.2), width: 1),
        ),
        child: Column(children: [Icon(icon, size: 32.sp, color: CustomColors.primaryColor), SizedBox(height: 8.h), black14w500(data: title)]),
      ),
    );
  }

  Future<void> _pickImage(String documentKey, ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        setState(() {
          if (_requiredDocuments.containsKey(documentKey)) {
            _requiredDocuments[documentKey] = File(image.path);
          } else {
            _additionalDocuments[documentKey] = File(image.path);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document uploaded successfully!'),
            backgroundColor: CustomColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
      );
    }
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