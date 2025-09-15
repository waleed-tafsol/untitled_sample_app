import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled_sample_app/utils/custom_colors.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 8, top: 8),
          decoration: BoxDecoration(
            color: CustomColors.purpleColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color:  CustomColors.whiteColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Decorative illustration
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [ CustomColors.purpleColorTint,  CustomColors.purpleColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:  CustomColors.purpleColor.withAlpha((0.4 * 255).toInt()),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.lock_outline, size: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Enter Verification Code',
                  style: theme.textTheme.headlineMedium?.copyWith(
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
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                const SizedBox(height: 32),
                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: 52,
                      height: 64,
                      decoration: BoxDecoration(
                        color: _focusNodes[index].hasFocus ? CustomColors.purpleColorTint : CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _focusNodes[index].hasFocus ? CustomColors.purpleColor.withAlpha((0.5 * 255).toInt()) : Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: _focusNodes[index].hasFocus ? CustomColors.purpleColor : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) => _onOtpChanged(index, value),
                          onTap: () {
                            _otpControllers[index].selection = TextSelection.fromPosition(
                              TextPosition(offset: _otpControllers[index].text.length),
                            );
                            setState(() {});
                          },
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) {
                              _onBackspace(index);
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                // Timer and Resend Button
                Consumer<AuthViewModel>(
                  builder: (context, authViewModel, child) {
                    return Column(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: authViewModel.otpTimerSeconds > 0
                              ? Column(
                                  key: const ValueKey('timer'),
                                  children: [
                                    Text(
                                      'Resend code in {authViewModel.otpTimerSeconds}s',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: CustomColors.purpleColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      height: 56,
                                      child: ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: CustomColors.purpleColorTint,
                                          foregroundColor: CustomColors.purpleColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14),
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
                                  ],
                                )
                              : Column(
                                  key: const ValueKey('resend'),
                                  children: [
                                    Text(
                                      'Didn\'t receive the code?',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      height: 56,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {
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
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.white,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            elevation: 0,
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
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
                // Verify Button
                Consumer<AuthViewModel>(
                  builder: (context, authViewModel, child) {
                    return SizedBox(
                      height: 56,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            if (authViewModel.isOtpValid)
                              BoxShadow(
                                color: Colors.blue.shade100.withAlpha((0.5 * 255).toInt()),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: authViewModel.isOtpValid
                                ? const LinearGradient(
                                    colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: authViewModel.isOtpValid ? null : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(
                            onPressed: authViewModel.isOtpValid
                                ? () async {
                                    final success = await authViewModel.verifyOtp();
                                    if (success && mounted) {
                                      Navigator.pushNamed(context, registrationStepperRoute);
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: authViewModel.isOtpValid
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
