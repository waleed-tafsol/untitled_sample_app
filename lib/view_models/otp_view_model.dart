import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../services/auth_service.dart';

class OtpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  bool _isOtpValid = false;
  String _otp = '';
  Timer? _otpTimer;
  int _otpTimerSeconds = 0;
  String _phoneNumber = '';
  String _countryCode = '+61';

  // Getters
  bool get isOtpValid => _isOtpValid;
  String get otp => _otp;
  int get otpTimerSeconds => _otpTimerSeconds;
  String get phoneNumber => _phoneNumber;
  String get countryCode => _countryCode;

  // Initialize with phone number and country code
  void initializeOtp(String phoneNumber, String countryCode) {
    _phoneNumber = phoneNumber;
    _countryCode = countryCode;
    startOtpTimer();
  }

  Future<bool> verifyOtp() async {
    if (!_isOtpValid) {
      EasyLoading.showError('Please enter a valid 6-digit OTP');
      return false;
    }

    EasyLoading.show(status: 'Verifying OTP...');

    try {
      final isVerified = await _authService.verifyOtp(_phoneNumber, _otp);
      if (isVerified) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.showError('Invalid OTP. Please try again.');
        return false;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> resendOtp() async {
    if (_phoneNumber.isEmpty) {
      EasyLoading.showError('Phone number is required');
      return false;
    }

    EasyLoading.show(status: 'Sending OTP...');

    try {
      await _authService.resendOtp(_countryCode + _phoneNumber);
      EasyLoading.dismiss();
      startOtpTimer();
      return true;
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  void updateOtp(String otp) {
    _otp = otp;
    _validateOtp();
    notifyListeners();
  }

  void _validateOtp() {
    _isOtpValid = _otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(_otp);
  }

  void startOtpTimer() {
    _stopOtpTimer();
    _otpTimerSeconds = 120;
    notifyListeners();

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpTimerSeconds > 0) {
        _otpTimerSeconds--;
        notifyListeners();
      } else {
        _stopOtpTimer();
      }
    });
  }

  void _stopOtpTimer() {
    _otpTimer?.cancel();
    _otpTimer = null;
  }

  void resetState() {
    _otp = '';
    _isOtpValid = false;
    _stopOtpTimer();
    _otpTimerSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    print('otp provider is disposed');
    _stopOtpTimer();
    super.dispose();
  }
}