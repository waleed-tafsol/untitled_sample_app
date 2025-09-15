import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/widgets/user_form_fields_widget.dart';
import '../utils/custom_buttons.dart';
import '../utils/custom_colors.dart';
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
      builder: (_, authViewModel, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: authViewModel.getFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),
                    Text(
                      'Enter your Australian phone number to continue',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),
                    phoneFieldWidget(),
                    const SizedBox(height: 24),

                    // Error message
                    const Spacer(),
                    customButton(
                      text: 'Send OTP',
                      onTap: () async {
                        if (authViewModel.validateFormKey()) {
                          await authViewModel.sendOtp().then((value) {
                            if (value) {
                              Navigator.pushNamed(context, otpRoute);
                            }
                          });
                        }
                      },
                      colored: true,
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: authViewModel.getIsTermsAccepted,
                          onChanged: (value) {
                            authViewModel.isTermsAccepted = value ?? false;
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
