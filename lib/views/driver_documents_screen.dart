import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/custom_colors.dart';

class DriverDocumentsScreen extends StatefulWidget {
  const DriverDocumentsScreen({super.key});

  @override
  State<DriverDocumentsScreen> createState() => _DriverDocumentsScreenState();
}

class _DriverDocumentsScreenState extends State<DriverDocumentsScreen> {
  final Map<String, bool> _uploadedDocuments = {
    'driverLicense': false,
    'vehicleRegistration': false,
    'insuranceCertificate': false,
    'backgroundCheck': false,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
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
                    Text(
                      'Required Documents',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.blackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please upload all required documents to complete your registration',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    color: CustomColors.blackColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Documents List
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _buildDocumentUpload(
                  'Driver License',
                  'Upload front and back of your driver license',
                  'driverLicense',
                  Iconsax.card,
                ),
                SizedBox(height: 16.h),
                _buildDocumentUpload(
                  'Vehicle Registration',
                  'Upload your vehicle registration certificate',
                  'vehicleRegistration',
                  Iconsax.car,
                ),
                SizedBox(height: 16.h),
                _buildDocumentUpload(
                  'Insurance Certificate',
                  'Upload your vehicle insurance certificate',
                  'insuranceCertificate',
                  Iconsax.shield_tick,
                ),
                SizedBox(height: 16.h),
                _buildDocumentUpload(
                  'Background Check',
                  'Upload your background check certificate',
                  'backgroundCheck',
                  Iconsax.verify,
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Upload Progress
          _buildUploadProgress(),
        ],
      ),
    );
  }

  Widget _buildDocumentUpload(
    String title,
    String subtitle,
    String documentKey,
    IconData icon,
  ) {
    final isUploaded = _uploadedDocuments[documentKey] ?? false;
    
    return GestureDetector(
      onTap: () => _uploadDocument(documentKey),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isUploaded 
                ? CustomColors.primaryColor 
                : CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isUploaded 
              ? CustomColors.primaryColor.withValues(alpha: 0.1) 
              : CustomColors.whiteColor,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isUploaded 
                    ? CustomColors.primaryColor 
                    : CustomColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                isUploaded ? Iconsax.tick_circle : icon,
                color: isUploaded 
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
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isUploaded)
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

  Widget _buildUploadProgress() {
    final uploadedCount = _uploadedDocuments.values.where((uploaded) => uploaded).length;
    final totalCount = _uploadedDocuments.length;
    final progress = uploadedCount / totalCount;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Iconsax.import,
                color: CustomColors.primaryColor,
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Upload Progress',
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.blackColor,
                ),
              ),
              const Spacer(),
              Text(
                '$uploadedCount/$totalCount',
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: CustomColors.primaryColor.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.primaryColor),
            borderRadius: BorderRadius.circular(4.r),
          ),
          SizedBox(height: 8.h),
          Text(
            progress == 1.0
                ? 'All documents uploaded successfully!'
                : 'Upload all documents to continue',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 12.sp,
              color: CustomColors.blackColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  void _uploadDocument(String documentKey) {
    // Simulate document upload
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CustomColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Icon(
              Iconsax.import,
              color: CustomColors.primaryColor,
              size: 24.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Upload Document',
              style: TextStyle(
                fontFamily: 'CircularStd',
                color: CustomColors.blackColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Choose how you want to upload the document:',
          style: TextStyle(
            fontFamily: 'CircularStd',
            color: CustomColors.blackColor.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        Navigator.pop(context);
                        _simulateUpload(documentKey);
                      },
                      child: Center(
                        child: Text(
                          'Camera',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        Navigator.pop(context);
                        _simulateUpload(documentKey);
                      },
                      child: Center(
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: CustomColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () => Navigator.pop(context),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _simulateUpload(String documentKey) {
    // Simulate upload process
    setState(() {
      _uploadedDocuments[documentKey] = true;
    });
    
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
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Getters for accessing document status
  Map<String, bool> getUploadedDocuments() {
    return Map.from(_uploadedDocuments);
  }

  bool areAllDocumentsUploaded() {
    return _uploadedDocuments.values.every((uploaded) => uploaded);
  }
}