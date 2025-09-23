import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../utils/custom_colors.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_font_style.dart';
import '../../view_models/driver_registration_view_model.dart';

class DriverInfoReviewScreen extends StatelessWidget {
  final Map<String, dynamic>? personalInfo;
  final Map<String, dynamic>? documents;
  final Map<String, dynamic>? vehicleInfo;
  final Map<String, dynamic>? paymentInfo;
  final Map<String, dynamic>? shiftInfo;

  const DriverInfoReviewScreen({
    super.key,
    this.personalInfo,
    this.documents,
    this.vehicleInfo,
    this.paymentInfo,
    this.shiftInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverRegistrationViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
            child: Column(
              children: [
                // Section 1: Review Your Information
                _buildReviewHeader(context),
                SizedBox(height: 20.h),
                
                // Section 2: Personal Details
                _buildPersonalDetailsSection(context, viewModel),
                SizedBox(height: 20.h),
                
                // Section 3: Address Information
                _buildAddressInformationSection(context, viewModel),
                SizedBox(height: 20.h),
                
                // Section 4: Registration & License
                _buildRegistrationLicenseSection(context, viewModel),
                SizedBox(height: 20.h),
                
                // Section 5: Emergency Contact
                _buildEmergencyContactSection(context, viewModel),
                SizedBox(height: 20.h),
                
                // Section 6: Documents Uploaded
                _buildDocumentsUploadedSection(context, viewModel),
                SizedBox(height: 20.h),
                
                // Section 7: Required Declarations
                _buildRequiredDeclarationsSection(context, viewModel),
                SizedBox(height: 40.h),
                
                // Submit Button
                _buildSubmitButton(context, viewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withOpacity(0.2),
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
              black18w500(data: 'Review Your Information'),
            ],
          ),
          SizedBox(height: 12.h),
          grey12(
            data: 'Please review all your information carefully. You can make changes by clicking the edit icons. Once you proceed, changes will require additional verification.',
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    return _buildInfoSection(
      context,
      title: 'Personal Details',
      onEdit: () {
        // Navigate to personal details edit screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigate to Personal Details Edit')),
        );
      },
      children: [
        _buildInfoRow('First Name', personalInfo?['firstName'] ?? viewModel.getFirstNameController.text),
        _buildInfoRow('Last Name', personalInfo?['lastName'] ?? viewModel.getLastNameController.text),
        _buildInfoRow('Email', personalInfo?['email'] ?? 'john.doe@example.com'),
        _buildInfoRow('Phone', personalInfo?['phone'] ?? '+61 123 456 789'),
        _buildInfoRow('Date of Birth', personalInfo?['dateOfBirth'] ?? 'Not provided'),
        _buildInfoRow('Gender', personalInfo?['gender'] ?? 'Not provided'),
      ],
    );
  }

  Widget _buildAddressInformationSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    return _buildInfoSection(
      context,
      title: 'Address Information',
      onEdit: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigate to Address Edit')),
        );
      },
      children: [
        _buildInfoRow('Street Address', personalInfo?['streetAddress'] ?? viewModel.getStreetAddressController.text),
        _buildInfoRow('Suburb', personalInfo?['suburb'] ?? viewModel.getSuburbController.text),
        _buildInfoRow('Postcode', personalInfo?['postcode'] ?? viewModel.getPostcodeController.text),
        _buildInfoRow('State', personalInfo?['state'] ?? 'NSW'),
        _buildInfoRow('Country', personalInfo?['country'] ?? 'Australia'),
      ],
    );
  }

  Widget _buildRegistrationLicenseSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    return _buildInfoSection(
      context,
      title: 'Registration & License',
      onEdit: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigate to Registration Edit')),
        );
      },
      children: [
        _buildInfoRow('ABN', personalInfo?['abn'] ?? viewModel.getAbnController.text),
        _buildInfoRow('E-Tag Number', personalInfo?['etagNumber'] ?? viewModel.getEtagNumberController.text),
        _buildInfoRow('License Number', personalInfo?['licenseNumber'] ?? viewModel.getLicenseNumberController.text),
        _buildInfoRow('License Expiry', personalInfo?['licenseExpiry'] ?? viewModel.getLicenseExpiryController.text),
        _buildInfoRow('License Class', personalInfo?['licenseClass'] ?? 'Not provided'),
        _buildInfoRow('Years of Experience', personalInfo?['experience'] ?? 'Not provided'),
      ],
    );
  }

  Widget _buildEmergencyContactSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    return _buildInfoSection(
      context,
      title: 'Emergency Contact',
      onEdit: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigate to Emergency Contact Edit')),
        );
      },
      children: [
        _buildInfoRow('Contact Name', personalInfo?['emergencyContactName'] ?? viewModel.getEmergencyContactNameController.text),
        _buildInfoRow('Contact Number', personalInfo?['emergencyContactNumber'] ?? viewModel.getEmergencyContactNumberController.text),
        _buildInfoRow('Contact Email', personalInfo?['emergencyContactEmail'] ?? viewModel.getEmergencyContactEmailController.text),
        _buildInfoRow('Relationship', personalInfo?['emergencyContactRelationship'] ?? 'Not provided'),
      ],
    );
  }

  Widget _buildDocumentsUploadedSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.document_download,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Documents Uploaded'),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Identity Verification Image
          if (viewModel.hasIdentityVerificationImage)
            _buildDocumentImageItem(
              'Identity Verification',
              viewModel.getIdentityVerificationImage!,
            ),
          
          // Show documents from passed parameter if available
          if (documents != null && documents!.isNotEmpty)
            _buildDocumentsFromParameter(),
          
          // Document Images Grid (2 per row)
          _buildDocumentImagesGrid(viewModel),
        ],
      ),
    );
  }

  Widget _buildDocumentsFromParameter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Documents',
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: CustomColors.blackColor,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.2,
          ),
          itemCount: documents!.length,
          itemBuilder: (context, index) {
            final entry = documents!.entries.elementAt(index);
            return _buildDocumentTextItem(entry.key, entry.value.toString());
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildDocumentTextItem(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: CustomColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 10.sp,
              color: CustomColors.blackColor.withOpacity(0.7),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentImagesGrid(DriverRegistrationViewModel viewModel) {
    final documentTitles = {
      'driverLicenseFront': 'Driver License (Front)',
      'driverLicenseBack': 'Driver License (Back)',
      'drivingRecord': 'Driving Record',
      'policeCheck': 'Police Check',
      'passport': 'Passport',
      'vevoDetails': 'VEVO Details',
      'englishCertificate': 'English Certificate',
    };

    final uploadedDocuments = documentTitles.entries
        .where((entry) => viewModel.hasDocumentImage(entry.key))
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: uploadedDocuments.length,
      itemBuilder: (context, index) {
        final entry = uploadedDocuments[index];
        return _buildDocumentImageItem(
          entry.value,
          viewModel.getDocumentImage(entry.key)!,
        );
      },
    );
  }

  Widget _buildDocumentImageItem(String title, File imageFile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: CustomColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: CustomColors.blackColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredDeclarationsSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.verify,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Required Declarations'),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Declaration 1
          _buildDeclarationItem(
            'I am qualified to operate a WATS Taxi',
            'I confirm that I am qualified to operate a WATS Taxi and meet all NSW regulatory requirements for taxi drivers.',
            'qualifiedToOperate',
            viewModel,
          ),
          SizedBox(height: 16.h),
          
          // Declaration 2
          _buildDeclarationItem(
            'I have read and consent to the Driver\'s Agreement',
            'I have read and consent to the Driver\'s Agreement, including all terms and conditions for operating as a Captain Taxis driver.',
            'consentToAgreement',
            viewModel,
          ),
          SizedBox(height: 16.h),
          
          // Declaration 3
          _buildDeclarationItem(
            'I have read and consent to the Driver\'s Use of Information Statement',
            'I have read and consent to the Driver\'s Use of Information Statement regarding how my personal information will be collected, used, and stored.',
            'consentToInformationStatement',
            viewModel,
          ),
        ],
      ),
    );
  }

  Widget _buildDeclarationItem(
    String title,
    String description,
    String declarationKey,
    DriverRegistrationViewModel viewModel,
  ) {
    final currentValue = viewModel.getDeclaration(declarationKey);
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: currentValue == true 
              ? CustomColors.primaryColor 
              : CustomColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
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
          SizedBox(height: 8.h),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 12.sp,
              color: CustomColors.blackColor.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildDeclarationButton(
                'Yes',
                true,
                currentValue == true,
                () => viewModel.setDeclaration(declarationKey, true),
              ),
              SizedBox(width: 12.w),
              _buildDeclarationButton(
                'No',
                false,
                currentValue == false,
                () => viewModel.setDeclaration(declarationKey, false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeclarationButton(
    String text,
    bool value,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected 
              ? CustomColors.primaryColor 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: CustomColors.primaryColor,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected 
                ? CustomColors.whiteColor 
                : CustomColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, DriverRegistrationViewModel viewModel) {
    final canSubmit = viewModel.areAllDeclarationsAccepted &&
                     viewModel.areAllDocumentsUploaded;
    
    return customButton(
      text: 'Submit Registration',
      onTap: canSubmit ? () {
        // Handle submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration submitted successfully!'),
            backgroundColor: CustomColors.primaryColor,
          ),
        );
      } : () {
        // Show error message if not ready to submit
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please complete all required fields and accept all declarations.'),
            backgroundColor: Colors.red,
          ),
        );
      },
      colored: canSubmit,
      icon: Iconsax.check,
      height: 50,
    );
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required String title,
    required VoidCallback onEdit,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.user,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: black18w500(data: title),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Iconsax.edit,
                    color: CustomColors.primaryColor,
                    size: 16.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: CustomColors.blackColor.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not provided' : value,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: value.isEmpty 
                    ? CustomColors.blackColor.withOpacity(0.5)
                    : CustomColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}