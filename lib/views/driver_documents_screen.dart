import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          Text(
            'Required Documents',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please upload all required documents to complete your registration',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 20.h),
          _buildDocumentUpload(
            'Driver License',
            'Upload front and back of your driver license',
            'driverLicense',
            Icons.credit_card,
          ),
          SizedBox(height: 16.h),
          _buildDocumentUpload(
            'Vehicle Registration',
            'Upload your vehicle registration certificate',
            'vehicleRegistration',
            Icons.directions_car,
          ),
          SizedBox(height: 16.h),
          _buildDocumentUpload(
            'Insurance Certificate',
            'Upload your vehicle insurance certificate',
            'insuranceCertificate',
            Icons.security,
          ),
          SizedBox(height: 16.h),
          _buildDocumentUpload(
            'Background Check',
            'Upload your background check certificate',
            'backgroundCheck',
            Icons.verified_user,
          ),
          SizedBox(height: 20.h),
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
            color: isUploaded ? Colors.green : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isUploaded ? Colors.green.withOpacity(0.1) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isUploaded ? Colors.green : CustomColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                isUploaded ? Icons.check : icon,
                color: isUploaded ? Colors.white : CustomColors.primaryColor,
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isUploaded)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20.w,
              )
            else
              Icon(
                Icons.arrow_forward_ios,
                size: 16.w,
                color: Colors.grey.shade400,
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.upload_file,
                color: Colors.blue.shade600,
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Upload Progress',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade800,
                ),
              ),
              const Spacer(),
              Text(
                '$uploadedCount/$totalCount',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.blue.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
            borderRadius: BorderRadius.circular(4.r),
          ),
          SizedBox(height: 8.h),
          Text(
            progress == 1.0
                ? 'All documents uploaded successfully!'
                : 'Upload all documents to continue',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.blue.shade700,
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
        title: const Text('Upload Document'),
        content: const Text('Choose how you want to upload the document:'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _simulateUpload(documentKey);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _simulateUpload(documentKey);
            },
            child: const Text('Gallery'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
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
        content: Text('Document uploaded successfully!'),
        backgroundColor: Colors.green,
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
