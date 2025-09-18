import 'enums.dart';

String? validateFirstName(String? value){
  if (value == null || value.isEmpty) {
    return 'First name is required';
  }
  RegExp regex = RegExp(RegExpPattern.name.pattern);
  if(regex.hasMatch(value)){
    return RegExpPattern.name.errorMessage;
  }
  return null;
}


String? validatePhoneNumber(String? value){
  if (value == null || value.isEmpty || value == "+61") {
    return 'phone number is required';
  }
  RegExp regex = RegExp(RegExpPattern.phone.pattern);
  if(!regex.hasMatch(value)){
    return RegExpPattern.phone.errorMessage;
  }
  return null;
}


String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  // Regular expression for email validation
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    caseSensitive: false,
  );

  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null;
}