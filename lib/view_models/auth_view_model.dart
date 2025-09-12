import 'dart:async';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String _countryCode = '+61';
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get getFormKey => _formKey;

  bool _isLoading = false;
  String? _errorMessage;

  TextEditingController get getPhoneController => _phoneController;
  String get getCountryCode => _countryCode;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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


  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
    }
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<bool> sendOtp() async {

    _setLoading(true);

    try {
      await _authService.sendOtp(_countryCode+_phoneController.text);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp() async {
    if (!_isOtpValid) {
      _setError('Please enter a valid 6-digit OTP');
      return false;
    }

    _setLoading(true);

    try {
      final isVerified = await _authService.verifyOtp(_phoneController.text, _otp);
      
      if (isVerified) {
        _setLoading(false);
        return true;
      } else {
        _setError('Invalid OTP. Please try again.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> resendOtp() async {
    if ((_countryCode+_phoneController.text).isEmpty) {
      _setError('Phone number is required');
      return false;
    }

    _setLoading(true);

    try {
      await _authService.resendOtp(_countryCode+_phoneController.text);
      _setLoading(false);
      startOtpTimer();
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  void updateOtp(String otp) {
    _otp = otp;
    _validateOtp();
    _clearError();
    notifyListeners();
  }

  void _validateOtp() {
    _isOtpValid = _otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(_otp);
  }

  String get formattedPhoneNumber {
    if ((_countryCode+_phoneController.text).isEmpty) return '';
    // Format: +61 X XXXX XXXX
    if ((_countryCode+_phoneController.text).length >= 10) {
      return '${_countryCode+_phoneController.text.substring(0, 3)} ${_phoneController.text.substring(3, 4)} ${_phoneController.text.substring(4, 8)} ${_phoneController.text.substring(8)}';
    }
    return _countryCode+_phoneController.text;
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
    _isLoading = false;
    _errorMessage = null;
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
