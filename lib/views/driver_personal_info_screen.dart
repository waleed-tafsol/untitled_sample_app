import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../utils/custom_font_style.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        black18w500(data: 'Personal Detail'),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: driverRegistrationViewModel
                                    .getFirstNameController,
                                validator: validateFirstName,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  hintText: 'John',
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 10,
                                  ).w,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: TextFormField(
                                controller: driverRegistrationViewModel
                                    .getLastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Last Name is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  hintText: 'Smith',
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: 2,
                                  ).w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        phoneFieldWidget(viewOnly: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
