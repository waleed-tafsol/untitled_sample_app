import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled_sample_app/utils/enums.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _loginWith = LoginWith.phone.value;

  String get getLoginWith => _loginWith;

  set setLoginWith(String value) {
    _loginWith = value;
  }

  String _countryCode = '+61';

  bool _isTermsAccepted = false;


  bool get getIsTermsAccepted => _isTermsAccepted;

  set setIsTermsAccepted(bool value) {
    _isTermsAccepted = value;
    notifyListeners();
  }

  GlobalKey<FormState> get getFormKey => _formKey;

  TextEditingController get getPhoneController => _phoneController;

  String get getCountryCode => _countryCode;


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




  @override
  void dispose() {
    print('authprovider is disposed');
    _phoneController.dispose();
    super.dispose();
  }
}
