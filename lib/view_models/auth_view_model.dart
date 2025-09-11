import 'dart:async';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String _countryCode = '+61';
  final TextEditingController _phoneController = TextEditingController();
  
  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  String _phoneNumber = '';

  // Getters
  TextEditingController get getPhoneController => _phoneController;
  String get getCountryCode => _countryCode;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get phoneNumber => _phoneNumber;

  // Phone number validation
  bool _isPhoneValid = false;
  bool get isPhoneValid => _isPhoneValid;

  void setCountryCode(String value) {
    _countryCode = value;
    _validatePhoneNumber();
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    _validatePhoneNumber();
    _clearError();
    notifyListeners();
  }

  // Validate Australian phone number
  void _validatePhoneNumber() {
    // Australian phone number validation
    // Format: +61 X XXXX XXXX or +61 XXX XXX XXX
    final australianPhoneRegex = RegExp(r'^\+61[2-9]\d{8}$');
    _isPhoneValid = australianPhoneRegex.hasMatch(_phoneNumber);
  }

  // Clear error message
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
    }
  }

  // Set error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Send OTP
  Future<bool> sendOtp() async {
    if (!_isPhoneValid) {
      _setError('Please enter a valid Australian phone number');
      return false;
    }

    _setLoading(true);

    try {
      await _authService.sendOtp(_phoneNumber);
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp() async {
    if (!_isOtpValid) {
      _setError('Please enter a valid 6-digit OTP');
      return false;
    }

    _setLoading(true);

    try {
      final isVerified = await _authService.verifyOtp(_phoneNumber, _otp);
      
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

  // Resend OTP
  Future<bool> resendOtp() async {
    if (_phoneNumber.isEmpty) {
      _setError('Phone number is required');
      return false;
    }

    _setLoading(true);

    try {
      await _authService.resendOtp(_phoneNumber);
      _setLoading(false);
      // Start timer after successful resend
      startOtpTimer();
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // OTP validation
  bool _isOtpValid = false;
  bool get isOtpValid => _isOtpValid;
  String _otp = '';
  String get otp => _otp;

  // OTP Timer functionality
  Timer? _otpTimer;
  int _otpTimerSeconds = 0;
  int get otpTimerSeconds => _otpTimerSeconds;

  void updateOtp(String otp) {
    _otp = otp;
    _validateOtp();
    _clearError();
    notifyListeners();
  }

  void _validateOtp() {
    // OTP should be 6 digits
    _isOtpValid = _otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(_otp);
  }

  // Get formatted phone number for display
  String get formattedPhoneNumber {
    if (_phoneNumber.isEmpty) return '';
    // Format: +61 X XXXX XXXX
    if (_phoneNumber.length >= 10) {
      return '${_phoneNumber.substring(0, 3)} ${_phoneNumber.substring(3, 4)} ${_phoneNumber.substring(4, 8)} ${_phoneNumber.substring(8)}';
    }
    return _phoneNumber;
  }

  // Start OTP Timer (2 minutes = 120 seconds)
  void startOtpTimer() {
    _stopOtpTimer(); // Stop any existing timer
    _otpTimerSeconds = 120; // 2 minutes
    notifyListeners();
    
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _otpTimerSeconds--;
      if (_otpTimerSeconds <= 0) {
        _stopOtpTimer();
      }
      notifyListeners();
    });
  }

  // Stop OTP Timer
  void _stopOtpTimer() {
    _otpTimer?.cancel();
    _otpTimer = null;
  }

  // Reset all state
  void resetState() {
    _phoneNumber = '';
    _isLoading = false;
    _errorMessage = null;
    _isPhoneValid = false;
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
