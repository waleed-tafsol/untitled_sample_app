import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/custom_colors.dart';

class DriverInfoReviewScreen extends StatelessWidget {
  final Map<String, String> personalInfo;
  final Map<String, bool> documents;
  final Map<String, String> vehicleInfo;
  final Map<String, String> paymentInfo;
  final Map<String, String> shiftInfo;

  const DriverInfoReviewScreen({
    super.key,
    required this.personalInfo,
    required this.documents,
    required this.vehicleInfo,
    required this.paymentInfo,
    required this.shiftInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: SingleChildScrollView(
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
                        Iconsax.tick_circle,
                        color: CustomColors.primaryColor,
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Review Your Information',
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
                    'Please review all your information before submitting',
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
            
            // Personal Information Section
            _buildSection(
              'Personal Information',
              Iconsax.user,
              [
                _buildReviewItem('Full Name', personalInfo['fullName'] ?? 'Not provided'),
                _buildReviewItem('Email', personalInfo['email'] ?? 'Not provided'),
                _buildReviewItem('Date of Birth', personalInfo['dob'] ?? 'Not provided'),
                _buildReviewItem('Address', personalInfo['address'] ?? 'Not provided'),
                _buildReviewItem('Emergency Contact', personalInfo['emergencyContact'] ?? 'Not provided'),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Documents Section
            _buildSection(
              'Documents',
              Iconsax.document_text,
              [
                _buildReviewItem('Driver License', documents['driverLicense'] == true ? 'Uploaded' : 'Not uploaded'),
                _buildReviewItem('Vehicle Registration', documents['vehicleRegistration'] == true ? 'Uploaded' : 'Not uploaded'),
                _buildReviewItem('Insurance Certificate', documents['insuranceCertificate'] == true ? 'Uploaded' : 'Not uploaded'),
                _buildReviewItem('Background Check', documents['backgroundCheck'] == true ? 'Uploaded' : 'Not uploaded'),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Vehicle Information Section
            _buildSection(
              'Vehicle Information',
              Iconsax.car,
              [
                _buildReviewItem('Make', vehicleInfo['make'] ?? 'Not provided'),
                _buildReviewItem('Model', vehicleInfo['model'] ?? 'Not provided'),
                _buildReviewItem('Year', vehicleInfo['year'] ?? 'Not provided'),
                _buildReviewItem('Color', vehicleInfo['color'] ?? 'Not provided'),
                _buildReviewItem('License Plate', vehicleInfo['licensePlate'] ?? 'Not provided'),
                _buildReviewItem('Seating Capacity', vehicleInfo['seatingCapacity'] ?? 'Not provided'),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Payment Information Section
            _buildSection(
              'Payment Information',
              Iconsax.card,
              [
                _buildReviewItem('Payment Method', paymentInfo['method'] ?? 'Not selected'),
                _buildReviewItem('Account Details', paymentInfo['accountDetails'] ?? 'Not provided'),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Shift Information Section
            _buildSection(
              'Working Schedule',
              Iconsax.clock,
              [
                _buildReviewItem('Start Time', shiftInfo['startTime'] ?? 'Not set'),
                _buildReviewItem('End Time', shiftInfo['endTime'] ?? 'Not set'),
                _buildReviewItem('Working Days', shiftInfo['workingDays'] ?? 'Not set'),
              ],
            ),
            
            SizedBox(height: 32.h),
            
            // Terms and Conditions
            Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.info_circle,
                        color: CustomColors.primaryColor,
                        size: 20.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'By submitting this registration, you agree to our Terms of Service and Privacy Policy. You confirm that all information provided is accurate and complete.',
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.6),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: CustomColors.primaryColor,
              size: 20.w,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: CustomColors.blackColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: CustomColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: CustomColors.primaryColor.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                color: CustomColors.blackColor.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: CustomColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}