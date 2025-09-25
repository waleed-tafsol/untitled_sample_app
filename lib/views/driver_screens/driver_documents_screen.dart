import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/widgets/custom_app_bar_widget.dart';
import '../../utils/custom_colors.dart';
import '../../view_models/driver_documents_view_model.dart';
import '../identity_verification_screen.dart';

class DriverDocumentsScreen extends StatefulWidget {
  const DriverDocumentsScreen({super.key});

  static Widget withAppBar({Key? key}) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: ''),
        body: DriverDocumentsScreen(key: key));
  }
  @override
  State<DriverDocumentsScreen> createState() => _DriverDocumentsScreenState();
}

class _DriverDocumentsScreenState extends State<DriverDocumentsScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverDocumentsViewModel>(
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.getFormKeyForStep(1),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CustomColors.whiteColor,
                  CustomColors.primaryColor.withValues(alpha: 0.02),
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      _buildHeader(),
                      SizedBox(height: 32.h),

                      // Identity Verification Section
                      _buildIdentityVerificationSection(viewModel),
                      SizedBox(height: 32.h),

                      // Required Documents Section
                      _buildRequiredDocumentsSection(viewModel),
                      SizedBox(height: 32.h),

                      // Progress Summary
                      _buildProgressSummary(viewModel),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Document Verification',
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: CustomColors.blackColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Upload required documents for verification',
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
            color: CustomColors.blackColor.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildIdentityVerificationSection(DriverDocumentsViewModel viewModel) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.primaryColor.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
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
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Iconsax.scan,
                        color: CustomColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Identity Verification',
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.blackColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Take a selfie for identity verification',
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 14.sp,
                              color: CustomColors.blackColor.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildIdentityImagePreview(viewModel),
                SizedBox(height: 20.h),
                _buildVerificationButton(viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityImagePreview(DriverDocumentsViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: viewModel.hasIdentityVerificationImage
            ? Image.network(
                viewModel.getIdentityVerificationImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildEmptyImagePreview();
                },
              )
            : viewModel.getUpLoadingProfileImage > 0
                ? _buildUploadingPreview(viewModel)
                : _buildEmptyImagePreview(),
      ),
    );
  }

  Widget _buildEmptyImagePreview() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColors.primaryColor.withValues(alpha: 0.05),
            CustomColors.primaryColor.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.camera,
              size: 32.sp,
              color: CustomColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No image captured yet',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              color: CustomColors.blackColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingPreview(DriverDocumentsViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColors.primaryColor.withValues(alpha: 0.1),
            CustomColors.primaryColor.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.cloud_plus,
              size: 32.sp,
              color: CustomColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Uploading...',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              color: CustomColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 120.w,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: CustomColors.primaryColor.withValues(alpha: 0.2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: viewModel.getUpLoadingProfileImage,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  color: CustomColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationButton(DriverDocumentsViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IdentityVerificationScreen(),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.primaryColor,
          foregroundColor: CustomColors.whiteColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        icon: Icon(
          Iconsax.camera,
          size: 20.sp,
        ),
        label: Text(
          viewModel.hasIdentityVerificationImage ? 'Retake Photo' : 'Start Verification',
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildRequiredDocumentsSection(DriverDocumentsViewModel viewModel) {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.primaryColor.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
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
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Iconsax.document_text,
                        color: CustomColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Required Documents',
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.blackColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Upload all required documents for verification',
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 14.sp,
                              color: CustomColors.blackColor.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _buildDocumentList(viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentList(DriverDocumentsViewModel viewModel) {
    final documents = [
      {'title': 'Driver License (Front)', 'key': 'driverLicenseFront', 'icon': Iconsax.card},
      {'title': 'Driver License (Back)', 'key': 'driverLicenseBack', 'icon': Iconsax.card},
      {'title': 'Driving Record (5 years)', 'key': 'drivingRecord', 'icon': Iconsax.document},
      {'title': 'Police Check (6 months)', 'key': 'policeCheck', 'icon': Iconsax.verify},
      {'title': 'Passport', 'key': 'passport', 'icon': Iconsax.card},
      {'title': 'VEVO Details', 'key': 'vevoDetails', 'icon': Iconsax.document_download},
      {'title': 'English Certificate', 'key': 'englishCertificate', 'icon': Iconsax.book},
    ];

    return Column(
      children: documents.asMap().entries.map((entry) {
        final index = entry.key;
        final doc = entry.value;
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 400),
          child: SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(
              child: Padding(
                padding: EdgeInsets.only(bottom: index < documents.length - 1 ? 16.h : 0),
                child: _buildDocumentItem(
                  doc['title'] as String,
                  doc['key'] as String,
                  doc['icon'] as IconData,
                  viewModel,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDocumentItem(
    String title,
    String documentKey,
    IconData icon,
    DriverDocumentsViewModel viewModel,
  ) {
    final hasImage = viewModel.hasDocumentImage(documentKey);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => viewModel.pickDocumentImageWithGenerator(documentKey),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: hasImage 
                ? CustomColors.primaryColor.withValues(alpha: 0.05)
                : CustomColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: hasImage
                  ? CustomColors.primaryColor
                  : CustomColors.primaryColor.withValues(alpha: 0.2),
              width: 2,
            ),
            boxShadow: hasImage ? [
              BoxShadow(
                color: CustomColors.primaryColor.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ] : null,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: hasImage
                      ? CustomColors.primaryColor
                      : CustomColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  hasImage ? Iconsax.tick_circle : icon,
                  color: hasImage
                      ? CustomColors.whiteColor
                      : CustomColors.primaryColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      hasImage ? 'Document uploaded' : 'Tap to upload',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 13.sp,
                        color: hasImage 
                            ? CustomColors.primaryColor
                            : CustomColors.blackColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: hasImage
                      ? CustomColors.primaryColor.withValues(alpha: 0.1)
                      : CustomColors.blackColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  hasImage ? Iconsax.tick_circle : Iconsax.arrow_right_3,
                  color: hasImage
                      ? CustomColors.primaryColor
                      : CustomColors.blackColor.withValues(alpha: 0.4),
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSummary(DriverDocumentsViewModel viewModel) {
    final totalDocuments = 7; // Total number of required documents
    final uploadedDocuments = _getUploadedDocumentsCount(viewModel);
    final progress = uploadedDocuments / totalDocuments;

    return AnimationConfiguration.staggeredList(
      position: 2,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.primaryColor.withValues(alpha: 0.1),
                  CustomColors.primaryColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
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
                      Iconsax.chart_2,
                      color: CustomColors.primaryColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Upload Progress',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.blackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$uploadedDocuments of $totalDocuments documents uploaded',
                            style: TextStyle(
                              fontFamily: 'CircularStd',
                              fontSize: 14.sp,
                              color: CustomColors.blackColor.withValues(alpha: 0.7),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: CustomColors.primaryColor.withValues(alpha: 0.2),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: CustomColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${(progress * 100).toInt()}%',
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _getUploadedDocumentsCount(DriverDocumentsViewModel viewModel) {
    final documentKeys = [
      'driverLicenseFront',
      'driverLicenseBack',
      'drivingRecord',
      'policeCheck',
      'passport',
      'vevoDetails',
      'englishCertificate',
    ];
    
    int count = 0;
    for (String key in documentKeys) {
      if (viewModel.hasDocumentImage(key)) {
        count++;
      }
    }
    
    // Add identity verification if uploaded
    if (viewModel.hasIdentityVerificationImage) {
      count++;
    }
    
    return count;
  }
}
