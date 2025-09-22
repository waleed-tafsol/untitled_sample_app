import 'package:flutter/material.dart';

class DriverRegistrationViewModel extends ChangeNotifier {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  GlobalKey<FormState>? _formKey;

  TextEditingController get getFirstNameController => _firstNameController;

  TextEditingController get getLastNameController => _lastNameController;

  GlobalKey<FormState> get getFormKey {
    _formKey ??= GlobalKey<FormState>();
    return _formKey!;
  }

  bool validateFormKey() {
    if (_formKey?.currentState?.validate() ?? false) {
      return true;
    } else {
      return false;
    }
  }

  void resetFormKey() {
    _formKey = null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
