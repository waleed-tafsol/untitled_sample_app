
class DriverDocumentsRequest {
  final String? identityVerificationImage;
  final String? driverLicenseFront;
  final String? driverLicenseBack;
  final String? drivingRecord;
  final String? policeCheck;
  final String? passport;
  final String? vevoDetails;
  final String? englishCertificate;

  DriverDocumentsRequest({
    this.identityVerificationImage,
    this.driverLicenseFront,
    this.driverLicenseBack,
    this.drivingRecord,
    this.policeCheck,
    this.passport,
    this.vevoDetails,
    this.englishCertificate,
  });

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'identityVerificationImage': identityVerificationImage,
      'driverLicenseFront': driverLicenseFront,
      'driverLicenseBack': driverLicenseBack,
      'drivingRecord': drivingRecord,
      'policeCheck': policeCheck,
      'passport': passport,
      'vevoDetails': vevoDetails,
      'englishCertificate': englishCertificate,
    };
  }
}
