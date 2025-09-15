import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isTermsAccepted = false;

  bool get getIsTermsAccepted => _isTermsAccepted;

  set isTermsAccepted(bool value) {
    _isTermsAccepted = value;
    notifyListeners();
  }

  String _countryCode = '+61';
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get getFormKey => _formKey;

  TextEditingController get getPhoneController => _phoneController;

  String get getCountryCode => _countryCode;

  bool _isOtpValid = false;

  bool get isOtpValid => _isOtpValid;
  String _otp = '';

  String get otp => _otp;

  Timer? _otpTimer;
  int _otpTimerSeconds = 0;

  int get otpTimerSeconds => _otpTimerSeconds;

  void setCountryCode(String value) {
    _countryCode = value;
    notifyListeners();
  }

  bool validateFormKey() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendOtp() async {
    EasyLoading.show(status: 'Send OTP');
    try {
      await _authService.sendOtp(_countryCode + _phoneController.text);
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      EasyLoading.showError(e.toString());
      return false;
    }
  }

  Future<bool> verifyOtp() async {
    if (!_isOtpValid) {
      EasyLoading.showError('Please enter a valid 6-digit OTP');
      return false;
    }

    EasyLoading.show(status: 'Send OTP');

    try {
      final isVerified = await _authService.verifyOtp(
        _phoneController.text,
        _otp,
      );

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
    if ((_countryCode + _phoneController.text).isEmpty) {
      EasyLoading.showError('Phone number is required');
      return false;
    }

    EasyLoading.show(status: 'Send Otp..');

    try {
      await _authService.resendOtp(_countryCode + _phoneController.text);
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

  String get formattedPhoneNumber {
    if ((_countryCode + _phoneController.text).isEmpty) return '';
    // Format: +61 X XXXX XXXX
    if ((_countryCode + _phoneController.text).length >= 10) {
      return '${_countryCode + _phoneController.text.substring(0, 3)} ${_phoneController.text.substring(3, 4)} ${_phoneController.text.substring(4, 8)} ${_phoneController.text.substring(8)}';
    }
    return _countryCode + _phoneController.text;
  }

  void startOtpTimer() {
    _stopOtpTimer();
    _otpTimerSeconds = 120;
    notifyListeners();

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _otpTimerSeconds--;
      if (_otpTimerSeconds <= 0) {
        _stopOtpTimer();
      }
      notifyListeners();
    });
  }

  void _stopOtpTimer() {
    _otpTimer?.cancel();
    _otpTimer = null;
  }

  void resetState() {
    _phoneController.clear();
    _stopOtpTimer();
    _otpTimerSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _stopOtpTimer();
    _phoneController.dispose();
    super.dispose();
  }
}
