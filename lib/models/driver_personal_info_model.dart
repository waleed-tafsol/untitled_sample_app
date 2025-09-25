
class DriverPersonalInfoModel {
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

  DriverPersonalInfoModel({
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

  static DriverPersonalInfoModel fromJson(Map<String, dynamic> json) {
    return DriverPersonalInfoModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      streetAddress: json['streetAddress'] as String?,
      suburb: json['suburb'] as String?,
      postcode: json['postcode'] as String?,
      abn: json['abn'] as String?,
      etagNumber: json['etagNumber'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      licenseExpiry: json['licenseExpiry'] as String?,
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactNumber: json['emergencyContactNumber'] as String?,
      emergencyContactEmail: json['emergencyContactEmail'] as String?,
    );
  }
}
