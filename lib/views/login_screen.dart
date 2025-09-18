import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/enums.dart';
import 'package:untitled_sample_app/view_models/otp_view_model.dart';
import 'package:untitled_sample_app/widgets/user_form_fields_widget.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_font_style.dart';
import '../utils/validators.dart';
import '../view_models/auth_view_model.dart';
import '../route_generator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0).w,
              child: Form(
                key: authViewModel.getFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8.h),
                    Text(
                      'Enter your Australian phone number to continue',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 40.h),
                    authViewModel.getLoginWith == LoginWith.phone.value
                        ? phoneFieldWidget()
                        : emailFieldWidget(),
                    SizedBox(height: 20.h),
                    grey14(data: 'Or'),
                    SizedBox(height: 10.h),
                    TextButton(
                      onPressed: () {
                        if (authViewModel.getLoginWith ==
                            LoginWith.phone.value) {
                          authViewModel.setLoginWith = LoginWith.email.value;
                        } else {
                          authViewModel.setLoginWith = LoginWith.phone.value;
                        }
                      },
                      child: primary14w500(
                        data:
                            'Login with ${authViewModel.getLoginWith == LoginWith.phone.value ? LoginWith.email.value : LoginWith.phone.value}',
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Error message
                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: authViewModel.getIsTermsAccepted,
                          onChanged: (value) {
                            authViewModel.setIsTermsAccepted = value ?? false;
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        Expanded(
                          child: Text(
                            'By continuing, you agree to our Terms of Service and Privacy Policy',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey.shade500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    customButton(
                      text: 'Send OTP',
                      onTap: () async {
                        final navigator = Navigator.of(context);

                        if (authViewModel.validateFormKey()) {
                          context.read<OtpViewModel>().setPhoneNumber =
                              (authViewModel.getCountryCode +
                              authViewModel.getPhoneController.text);
                          if (authViewModel.getIsTermsAccepted) {
                            await context.read<OtpViewModel>().sendOtp().then((
                              value,
                            ) {
                              if (value) {
                                navigator.pushNamed(otpRoute);
                              }
                            });
                          }
                          else{
                            EasyLoading.showError('Kindly accept terms and services');
                          }
                        }
                      },
                      colored: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
