import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_font_style.dart';
import '../../view_models/driver_registration_view_model.dart';
import '../../widgets/image_source_bottom_sheet.dart';

class DriverDocumentsScreen extends StatefulWidget {
  const DriverDocumentsScreen({super.key});

  @override
  State<DriverDocumentsScreen> createState() => _DriverDocumentsScreenState();
}

class _DriverDocumentsScreenState extends State<DriverDocumentsScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverRegistrationViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
        child: Column(
          children: [
            black24w600(data: 'Document Verification'),
            grey12(data: 'Upload required documents for verification'),
            SizedBox(height: 20.h),
            
            // Identity Verification Section
            Container(
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
                      black18w500(data: 'Identity Verification'),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  grey12(
                    data: 'Take a selfie for identity verification',
                  ),
                  SizedBox(height: 20.h),
                  
                  // Identity Image Display or Capture Button
                  if (viewModel.hasIdentityVerificationImage)
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: CustomColors.primaryColor.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          viewModel.getIdentityVerificationImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: CustomColors.primaryColor.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.camera,
                            size: 48.sp,
                            color: CustomColors.primaryColor.withValues(alpha: 0.6),
                          ),
                          SizedBox(height: 12.h),
                          grey12(
                            data: 'No image captured yet',
                            centre: true,
                          ),
                        ],
                      ),
                    ),
                  
                  SizedBox(height: 20.h),
                  
                  // Start Verification Button
                  customButton(
                    text: viewModel.hasIdentityVerificationImage ? 'Retake Photo' : 'Start Verification',
                    onTap: () => _captureIdentityImage(viewModel),
                    colored: true,
                    icon: Iconsax.camera,
                    height: 50,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Required Documents Section
            Container(
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
                    data: 'Upload all required documents for verification',
                  ),
                  SizedBox(height: 20.h),
                  
                  // Document List
                  _buildDocumentItem(
                    'Driver License (Front)',
                    'driverLicenseFront',
                    Iconsax.card,
                    viewModel,
                  ),
                  SizedBox(height: 16.h),
                  _buildDocumentItem(
                    'Driver License (Back)',
                    'driverLicenseBack',
                    Iconsax.card,
                    viewModel,
                  ),
                  SizedBox(height: 16.h),
                  _buildDocumentItem(
                    'Driving Record (5 years)',
                    'drivingRecord',
                    Iconsax.document,
                    viewModel,
                  ),
                  SizedBox(height: 16.h),
                  _buildDocumentItem(
                    'Police Check (6 months)',
                    'policeCheck',
                    Iconsax.verify,
                    viewModel,
                  ),
                  SizedBox(height: 16.h),
                  _buildDocumentItem(
                    'Passport',
                    'passport',
                    Iconsax.card,
                    viewModel,
                  ),
                  SizedBox(height: 16.h),
                  _buildDocumentItem(
                    'VEVO Details',
                    'vevoDetails',
                    Iconsax.document_download,
                    viewModel,
                  ),
                  SizedBox(height: 16.h),
                  _buildDocumentItem(
                    'English Certificate',
                    'englishCertificate',
                    Iconsax.book,
                    viewModel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
  }

  Widget _buildDocumentItem(String title, String documentKey, IconData icon, DriverRegistrationViewModel viewModel) {
    final hasImage = viewModel.hasDocumentImage(documentKey);
    
    return GestureDetector(
      onTap: () => ImageSourceBottomSheet.show(
        context: context,
        title: 'Select Image Source',
        subtitle: 'Choose how you want to add the image',
        onImageSelected: (source) => _pickImage(documentKey, source, viewModel),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[3],
          color: CustomColors.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: hasImage 
                ? CustomColors.primaryColor 
                : CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: hasImage 
                    ? CustomColors.primaryColor 
                    : CustomColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                hasImage ? Iconsax.tick_circle : icon,
                color: hasImage 
                    ? CustomColors.whiteColor 
                    : CustomColors.primaryColor,
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
                  grey12(
                    data: hasImage ? 'Document uploaded' : 'Tap to upload',
                  ),
                ],
              ),
            ),
            if (hasImage)
              Icon(
                Iconsax.tick_circle,
                color: CustomColors.primaryColor,
                size: 20.w,
              )
            else
              Icon(
                Iconsax.arrow_right_3,
                size: 16.w,
                color: CustomColors.blackColor.withValues(alpha: 0.4),
              ),
          ],
        ),
      ),
    );
  }

  // Capture identity verification image
  Future<void> _captureIdentityImage(DriverRegistrationViewModel viewModel) async {
    try {
      await viewModel.captureIdentityImage();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Identity verification photo captured!',
            style: TextStyle(
              fontFamily: 'CircularStd',
              color: CustomColors.whiteColor,
            ),
          ),
          backgroundColor: CustomColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to capture image: $e',
            style: TextStyle(
              fontFamily: 'CircularStd',
              color: CustomColors.whiteColor,
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    }
  }


  // Pick image from camera or gallery
  Future<void> _pickImage(String documentKey, ImageSource source, DriverRegistrationViewModel viewModel) async {
    try {
      await viewModel.pickDocumentImage(documentKey, source);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Document uploaded successfully!',
            style: TextStyle(
              fontFamily: 'CircularStd',
              color: CustomColors.whiteColor,
            ),
          ),
          backgroundColor: CustomColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to pick image: $e',
            style: TextStyle(
              fontFamily: 'CircularStd',
              color: CustomColors.whiteColor,
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    }
  }

}