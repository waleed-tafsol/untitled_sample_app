import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/custom_colors.dart';
import '../utils/phone_formator.dart';
import '../view_models/auth_view_model.dart';
import '../view_models/otp_view_model.dart';
import '../route_generator.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authViewModel = context.read<AuthViewModel>();
      final otpViewModel = context.read<OtpViewModel>();
      otpViewModel.initializeOtp(
        authViewModel.getPhoneController.text,
        authViewModel.getCountryCode,
      );
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    _updateOtp();
  }

  void _updateOtp() {
    String otp = _otpControllers.map((c) => c.text).join();
    context.read<OtpViewModel>().updateOtp(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<OtpViewModel, ({String countryCode, String phoneNumber, int otpTimerSeconds, bool isOtpValid})>(
      selector: (context, otpViewModel) => (
        countryCode: otpViewModel.countryCode,
        phoneNumber: otpViewModel.phoneNumber,
        otpTimerSeconds: otpViewModel.otpTimerSeconds,
        isOtpValid: otpViewModel.isOtpValid,
      ),
      builder: (context, data, child) {
        final otpViewModel = context.read<OtpViewModel>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: CustomColors.purpleColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Header
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [CustomColors.purpleColorTint, CustomColors.purpleColor],
                      ),
                    ),
                    child: const Icon(Icons.lock_outline, size: 40, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 32),
                
                Text(
                  'Enter Verification Code',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'We sent a 6-digit code to ${formattedPhoneNumber(countryCode: data.countryCode, phoneNumber: data.phoneNumber)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _focusNodes[index].hasFocus ? CustomColors.purpleColorTint : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _focusNodes[index].hasFocus ? CustomColors.purpleColor : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: TextFormField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => _onOtpChanged(index, value),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),

                // Timer and Resend
                if (data.otpTimerSeconds > 0)
                  Text(
                    'Resend code in ${data.otpTimerSeconds}s',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.purpleColor),
                    textAlign: TextAlign.center,
                  )
                else
                  TextButton(
                    onPressed: () async {
                      final success = await otpViewModel.resendOtp();
                      if (success && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('OTP sent successfully'), backgroundColor: Colors.green),
                        );
                      }
                    },
                    child: const Text('Resend Code', style: TextStyle(fontSize: 16)),
                  ),
                const SizedBox(height: 40),

                // Verify Button
                ElevatedButton(
                  onPressed: data.isOtpValid
                      ? () async {
                          final success = await otpViewModel.verifyOtp();
                          if (success && mounted) {
                            Navigator.pushReplacementNamed(context, registrationStepperRoute);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.purpleColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: data.isOtpValid ? 4 : 0,
                  ),
                  child: const Text('Verify OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
