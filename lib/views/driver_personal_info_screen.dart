import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/custom_font_style.dart';
import 'package:untitled_sample_app/utils/enums.dart';
import 'package:untitled_sample_app/view_models/auth_view_model.dart';
import '../utils/custom_colors.dart';
import '../utils/validators.dart';
import '../view_models/driver_registration_view_model.dart';
import '../widgets/user_form_fields_widget.dart';

class DriverPersonalInfoScreen extends StatefulWidget {
  const DriverPersonalInfoScreen({super.key});

  @override
  State<DriverPersonalInfoScreen> createState() =>
      _DriverPersonalInfoScreenState();
}

class _DriverPersonalInfoScreenState extends State<DriverPersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DriverRegistrationViewModel>(
      builder: (_, driverRegistrationViewModel, _) {
        return Form(
          key: driverRegistrationViewModel.getFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w,bottom: 20.h),
              child: Column(
                children: [
                  black24w600(data: 'Personal Information'),
                  grey12(data: 'Enter your personal details'),
                  SizedBox(height: 20.h),
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
                              Iconsax.user,
                              color: CustomColors.primaryColor,
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            black18w500(data: 'Personal Details'),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        grey12(
                          data:
                              'Please provide your personal information to complete registration',
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: kElevationToShadow[3],
                                  color: CustomColors.whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: driverRegistrationViewModel
                                      .getFirstNameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 14.h,
                                    ),
                                    prefixIcon: Icon(Iconsax.user),
                                    labelText: 'First Name',
                                    hintText: 'John',
                                  ),
                                  validator: validateFirstName,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: kElevationToShadow[3],
                                  color: CustomColors.whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: driverRegistrationViewModel
                                      .getLastNameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 14.h,
                                    ),
                                    prefixIcon: Icon(Iconsax.user),
                                    labelText: 'Last Name',
                                    hintText: 'Smith',
                                  ),
                                  validator: validateFirstName,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[3],
                            color: CustomColors.whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                          ),
                          child: phoneFieldWidget(
                            viewOnly:
                                context.read<AuthViewModel>().getLoginWith ==
                                LoginWith.phone.value,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[3],
                            color: CustomColors.whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                          ),
                          child: emailFieldWidget(
                            viewOnly:
                                context.read<AuthViewModel>().getLoginWith ==
                                LoginWith.email.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
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
                              Iconsax.location,
                              color: CustomColors.primaryColor,
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            black18w500(data: 'Address Details'),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        grey12(
                          data:
                              'Please provide your address information for verification',
                        ),
                        SizedBox(height: 20.h),

                        // Street Address
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[3],
                            color: CustomColors.whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.r),
                            ),
                          ),
                          child: TextFormField(
                            controller: driverRegistrationViewModel
                                .getStreetAddressController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 14.h,
                              ),
                              prefixIcon: Icon(Iconsax.home),
                              labelText: 'Street Address',
                              hintText: '123 Main Street',
                            ),
                            validator: validateStreetAddress,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Suburb and Postcode Row
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: kElevationToShadow[3],
                                  color: CustomColors.whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: driverRegistrationViewModel
                                      .getSuburbController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 14.h,
                                    ),
                                    prefixIcon: Icon(Iconsax.location),
                                    labelText: 'Suburb',
                                    hintText: 'Sydney',
                                  ),
                                  validator: validateSuburb,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: kElevationToShadow[3],
                                  color: CustomColors.whiteColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: driverRegistrationViewModel
                                      .getPostcodeController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 14.h,
                                    ),
                                    prefixIcon: Icon(Iconsax.code),
                                    labelText: 'Postcode',
                                    hintText: '2000',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: validatePostcode,
                                ),
                              ),
                            ),
                         ],
                       ),
                     ],
                   ),
                 ),
                 SizedBox(height: 24.h),
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
                             Iconsax.card,
                             color: CustomColors.primaryColor,
                             size: 24.sp,
                           ),
                           SizedBox(width: 12.w),
                           black18w500(data: 'License & Registration'),
                         ],
                       ),
                       SizedBox(height: 8.h),
                       grey12(
                         data:
                             'Please provide your license and registration details',
                       ),
                       SizedBox(height: 20.h),

                       // ABN and E-tag Row
                       Row(
                         children: [
                           Expanded(
                             child: Container(
                               decoration: BoxDecoration(
                                 boxShadow: kElevationToShadow[3],
                                 color: CustomColors.whiteColor,
                                 borderRadius: BorderRadius.all(
                                   Radius.circular(15.r),
                                 ),
                               ),
                               child: TextFormField(
                                 controller: driverRegistrationViewModel
                                     .getAbnController,
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.symmetric(
                                     horizontal: 10.w,
                                     vertical: 14.h,
                                   ),
                                   prefixIcon: Icon(Iconsax.building),
                                   labelText: 'ABN',
                                   hintText: '12345678901',
                                 ),
                                 keyboardType: TextInputType.number,
                                 validator: validateAbn,
                               ),
                             ),
                           ),
                           SizedBox(width: 12.w),
                           Expanded(
                             child: Container(
                               decoration: BoxDecoration(
                                 boxShadow: kElevationToShadow[3],
                                 color: CustomColors.whiteColor,
                                 borderRadius: BorderRadius.all(
                                   Radius.circular(15.r),
                                 ),
                               ),
                               child: TextFormField(
                                 controller: driverRegistrationViewModel
                                     .getEtagNumberController,
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.symmetric(
                                     horizontal: 10.w,
                                     vertical: 14.h,
                                   ),
                                   prefixIcon: Icon(Iconsax.tag),
                                   labelText: 'E-tag Number',
                                   hintText: 'ET123456',
                                 ),
                                 validator: validateEtagNumber,
                               ),
                             ),
                           ),
                         ],
                       ),
                       SizedBox(height: 20.h),

                       // License Number and Expiry Row
                       Row(
                         children: [
                           Expanded(
                             child: Container(
                               decoration: BoxDecoration(
                                 boxShadow: kElevationToShadow[3],
                                 color: CustomColors.whiteColor,
                                 borderRadius: BorderRadius.all(
                                   Radius.circular(15.r),
                                 ),
                               ),
                               child: TextFormField(
                                 controller: driverRegistrationViewModel
                                     .getLicenseNumberController,
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.symmetric(
                                     horizontal: 10.w,
                                     vertical: 14.h,
                                   ),
                                   prefixIcon: Icon(Iconsax.driving),
                                   labelText: 'License Number',
                                   hintText: '123456789',
                                 ),
                                 validator: validateLicenseNumber,
                               ),
                             ),
                           ),
                           SizedBox(width: 12.w),
                           Expanded(

                             child: Container(
                               decoration: BoxDecoration(
                                 boxShadow: kElevationToShadow[3],
                                 color: CustomColors.whiteColor,
                                 borderRadius: BorderRadius.all(
                                   Radius.circular(15.r),
                                 ),
                               ),
                               child: TextFormField(
                                 controller: driverRegistrationViewModel
                                     .getLicenseExpiryController,
                                 decoration: InputDecoration(
                                   contentPadding: EdgeInsets.symmetric(
                                     horizontal: 10.w,
                                     vertical: 14.h,
                                   ),
                                   prefixIcon: Icon(Iconsax.calendar),
                                   labelText: 'License Expiry',
                                   hintText: 'DD/MM/YYYY',
                                   suffixIcon: IconButton(
                                     icon: Icon(Iconsax.calendar_1),
                                     onPressed: () async {
                                       final DateTime? pickedDate = await showDatePicker(
                                         context: context,
                                         initialDate: DateTime.now().add(Duration(days: 365)),
                                         firstDate: DateTime.now(),
                                         lastDate: DateTime.now().add(Duration(days: 3650)), // 10 years from now
                                         builder: (context, child) {
                                           return Theme(
                                             data: Theme.of(context).copyWith(
                                               colorScheme: ColorScheme.light(
                                                 primary: CustomColors.primaryColor,
                                                 onPrimary: CustomColors.whiteColor,
                                                 surface: CustomColors.whiteColor,
                                                 onSurface: CustomColors.blackColor,
                                               ),
                                             ),
                                             child: child!,
                                           );
                                         },
                                       );
                                       if (pickedDate != null) {
                                         final formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                         driverRegistrationViewModel.getLicenseExpiryController.text = formattedDate;
                                       }
                                     },
                                   ),
                                 ),
                                 readOnly: true,
                                 validator: validateLicenseExpiry,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                 SizedBox(height: 24.h),
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
                             Iconsax.call,
                             color: CustomColors.primaryColor,
                             size: 24.sp,
                           ),
                           SizedBox(width: 12.w),
                           black18w500(data: 'Emergency Contact'),
                         ],
                       ),
                       SizedBox(height: 8.h),
                       grey12(
                         data:
                             'Please provide emergency contact information',
                       ),
                       SizedBox(height: 20.h),

                       // Emergency Contact Name
                       Container(
                         decoration: BoxDecoration(
                           boxShadow: kElevationToShadow[3],
                           color: CustomColors.whiteColor,
                           borderRadius: BorderRadius.all(
                             Radius.circular(15.r),
                           ),
                         ),
                         child: TextFormField(
                           controller: driverRegistrationViewModel
                               .getEmergencyContactNameController,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.symmetric(
                               horizontal: 10.w,
                               vertical: 14.h,
                             ),
                             prefixIcon: Icon(Iconsax.user),
                             labelText: 'Contact Name',
                             hintText: 'John Smith',
                           ),
                           validator: validateEmergencyContactName,
                         ),
                       ),
                       SizedBox(height: 20.h),

                       // Emergency Contact Number and Email Row

                           Container(
                             decoration: BoxDecoration(
                               boxShadow: kElevationToShadow[3],
                               color: CustomColors.whiteColor,
                               borderRadius: BorderRadius.all(
                                 Radius.circular(15.r),
                               ),
                             ),
                             child: TextFormField(
                               controller: driverRegistrationViewModel
                                   .getEmergencyContactNumberController,
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.symmetric(
                                   horizontal: 10.w,
                                   vertical: 14.h,
                                 ),
                                 prefixIcon: Icon(Iconsax.mobile),
                                 labelText: 'Contact Number',
                                 hintText: '0412 345 678',
                               ),
                               keyboardType: TextInputType.phone,
                               validator: validateEmergencyContactNumber,
                             ),
                           ),
              SizedBox(height: 20.h),

              Container(
                decoration: BoxDecoration(
                  boxShadow: kElevationToShadow[3],
                  color: CustomColors.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.r),
                  ),
                ),
                child: TextFormField(
                  controller: driverRegistrationViewModel
                      .getEmergencyContactEmailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 14.h,
                    ),
                    prefixIcon: Icon(Iconsax.sms),
                    labelText: 'Email',
                    hintText: 'john@example.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmergencyContactEmail,
                ),
              ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
          ),
        );
      },
    );
  }
}
