import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_view_model.dart';
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
    // Start the timer when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().startOtpTimer();
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
    if (value.length == 1) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    _updateOtp();
  }

  void _onBackspace(int index) {
    if (_otpControllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    _updateOtp();
  }

  void _updateOtp() {
    String otp = '';
    for (var controller in _otpControllers) {
      otp += controller.text;
    }
    context.read<AuthViewModel>().updateOtp(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Enter Verification Code',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return Text(
                    'We sent a 6-digit code to ${authViewModel.formattedPhoneNumber}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              const SizedBox(height: 40),
              
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    height: 55,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                      onChanged: (value) => _onOtpChanged(index, value),
                      onTap: () {
                        _otpControllers[index].selection = TextSelection.fromPosition(
                          TextPosition(offset: _otpControllers[index].text.length),
                        );
                      },
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          _onBackspace(index);
                        }
                      },
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 30),
              
              // Timer and Resend Button
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return Column(
                    children: [
                      if (authViewModel.otpTimerSeconds > 0) ...[
                        Text(
                          'Resend code in ${authViewModel.otpTimerSeconds}s',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: null, // Disabled during timer
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              foregroundColor: Colors.grey.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Resend Code',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Didn\'t receive the code?',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: authViewModel.isLoading ? null : () async {
                              final success = await authViewModel.resendOtp();
                              if (success && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('OTP sent successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: authViewModel.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'Resend Code',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              
              const Spacer(),
              
              // Verify Button
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: authViewModel.isOtpValid && !authViewModel.isLoading
                          ? () async {
                              final success = await authViewModel.verifyOtp();
                              if (success && mounted) {
                                Navigator.pushNamed(context, registrationStepperRoute);
                              } else if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(authViewModel.errorMessage ?? 'Invalid OTP'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: authViewModel.isOtpValid && !authViewModel.isLoading
                            ? Colors.blue.shade600
                            : Colors.grey.shade300,
                        foregroundColor: authViewModel.isOtpValid && !authViewModel.isLoading
                            ? Colors.white
                            : Colors.grey.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: authViewModel.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
