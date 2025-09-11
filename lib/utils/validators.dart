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