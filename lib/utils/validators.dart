import 'enums.dart';

String? validateFirstName(String? value){
  if (value == null || value.isEmpty) {
    return 'First name is required';
  }
  RegExp regex = RegExp(RegExpPattern.name.pattern);
  if(!regex.hasMatch(value)){
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

String? validateStreetAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Street address is required';
  }
  if (value.length < 5) {
    return 'Please enter a complete street address';
  }
  return null;
}

String? validateSuburb(String? value) {
  if (value == null || value.isEmpty) {
    return 'Suburb is required';
  }
  if (value.length < 2) {
    return 'Please enter a valid suburb';
  }
  return null;
}

String? validatePostcode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Postcode is required';
  }
  
  // Australian postcode validation (4 digits)
  final postcodeRegex = RegExp(r'^\d{4}$');
  if (!postcodeRegex.hasMatch(value)) {
    return 'Please enter a valid 4-digit postcode';
  }
  
  return null;
}

String? validateAbn(String? value) {
  if (value == null || value.isEmpty) {
    return 'ABN is required';
  }
  
  // Australian ABN validation (11 digits)
  final abnRegex = RegExp(r'^\d{11}$');
  if (!abnRegex.hasMatch(value)) {
    return 'Please enter a valid 11-digit ABN';
  }
  
  return null;
}

String? validateEtagNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'E-tag number is required';
  }
  if (value.length < 6) {
    return 'Please enter a valid E-tag number';
  }
  return null;
}

String? validateLicenseNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'License number is required';
  }
  if (value.length < 6) {
    return 'Please enter a valid license number';
  }
  return null;
}

String? validateLicenseExpiry(String? value) {
  if (value == null || value.isEmpty) {
    return 'License expiry date is required';
  }
  
  // Date format validation (DD/MM/YYYY)
  final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!dateRegex.hasMatch(value)) {
    return 'Please enter date in DD/MM/YYYY format';
  }
  
  // Parse the date and check if it's in the future
  try {
    final parts = value.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    final selectedDate = DateTime(year, month, day);
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    
    if (selectedDate.isBefore(todayOnly)) {
      return 'License expiry date must be in the future';
    }
  } catch (e) {
    return 'Please enter a valid date';
  }
  
  return null;
}

String? validateEmergencyContactName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Emergency contact name is required';
  }
  if (value.length < 2) {
    return 'Please enter a valid contact name';
  }
  return null;
}

String? validateEmergencyContactNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Emergency contact number is required';
  }
  
  // Phone number validation (Australian format)
  final phoneRegex = RegExp(r'^(\+61|0)[2-9]\d{8}$');
  if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
    return 'Please enter a valid Australian phone number';
  }
  
  return null;
}

String? validateEmergencyContactEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Emergency contact email is required';
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