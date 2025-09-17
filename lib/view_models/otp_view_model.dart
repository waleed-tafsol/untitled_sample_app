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

  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool get isOtpValid => _isOtpValid;
  String get otp => _otp;
  int get otpTimerSeconds => _otpTimerSeconds;
  String get getPhoneNumber => _phoneNumber;

  set setPhoneNumber(String value){
    _phoneNumber = value;
  }
  List<TextEditingController> get otpControllers => _otpControllers;
  List<FocusNode> get focusNodes => _focusNodes;

  void initializeOtp(String phoneNumber, String countryCode) {
    _phoneNumber = phoneNumber;
 //   _countryCode = countryCode;
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

  Future<bool> sendOtp() async {
    EasyLoading.show(status: 'Send OTP');
    try {
      await _authService.sendOtp(_phoneNumber);
      EasyLoading.dismiss();
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

  void onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    _updateOtpFromControllers();
  }

  void _updateOtpFromControllers() {
    String otp = _otpControllers.map((c) => c.text).join();
    updateOtp(otp);
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
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

}