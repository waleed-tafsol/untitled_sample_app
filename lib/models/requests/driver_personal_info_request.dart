import 'package:http/http.dart';

import '../base_response_model.dart';

class DriverPersonalInfoRequest  {
  final String? firstName;
  final String? lastName;
  final String? streetAddress;
  final String? suburb;
  final String? postcode;
  final String? abn;
  final String? etagNumber;
  final String? licenseNumber;
  final String? licenseExpiry;
  final String? emergencyContactName;
  final String? emergencyContactNumber;
  final String? emergencyContactEmail;

  DriverPersonalInfoRequest({
    this.firstName,
    this.lastName,
    this.streetAddress,
    this.suburb,
    this.postcode,
    this.abn,
    this.etagNumber,
    this.licenseNumber,
    this.licenseExpiry,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.emergencyContactEmail,
  });

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'streetAddress': streetAddress,
      'suburb': suburb,
      'postcode': postcode,
      'abn': abn,
      'etagNumber': etagNumber,
      'licenseNumber': licenseNumber,
      'licenseExpiry': licenseExpiry,
      'emergencyContactName': emergencyContactName,
      'emergencyContactNumber': emergencyContactNumber,
      'emergencyContactEmail': emergencyContactEmail,
    };
  }
}
