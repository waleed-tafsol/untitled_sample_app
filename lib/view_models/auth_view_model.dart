import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../app_init.dart';
import '../route_generator.dart';
import '../services/auth_service.dart';
import '../utils/enums.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    _callPackageInfo();
  }

  final AuthService _authService = AuthService();

  String _version = '';

  String get getVersion => _version;
  String _buildNumber = '';

  String get getBuildNumber => _buildNumber;

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _loginWith = LoginWith.phone.value;

  String _countryCode = '+61';

  bool _isTermsAccepted = false;

  String get getLoginWith => _loginWith;

  set setLoginWith(String value) {
    _loginWith = value;
    _formKey.currentState!.reset();
    _phoneController.clear();
    _emailController.clear();
    notifyListeners();
  }

  bool get getIsTermsAccepted => _isTermsAccepted;

  set setIsTermsAccepted(bool value) {
    _isTermsAccepted = value;
    notifyListeners();
  }

  GlobalKey<FormState> get getFormKey => _formKey;

  TextEditingController get getPhoneController => _phoneController;

  TextEditingController get getEmailController => _emailController;

  String get getCountryCode => _countryCode;

  void setCountryCode(String value) {
    _countryCode = value;
    notifyListeners();
  }

  Future<void> _callPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    _navigateToLogin();
    notifyListeners();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(navigatorKey.currentContext!, loginRoute);
    });
  }

  bool validateFormKey() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    print('authprovider is disposed');
    _phoneController.dispose();
    _emailController.dispose();
    _formKey.currentState!.reset();
    super.dispose();
  }
}
