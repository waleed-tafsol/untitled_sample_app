import 'package:flutter/material.dart';

class DriverRegistrationViewModel extends ChangeNotifier {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController get getFirstNameController => _firstNameController;

  TextEditingController get getLastNameController => _lastNameController;

  GlobalKey<FormState> get getFormKey => _formKey;

  bool validateFormKey() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
