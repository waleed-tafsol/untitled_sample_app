
class DriverDocumentsModel {
  final String? identityVerificationImage;
  final String? driverLicenseFront;
  final String? driverLicenseBack;
  final String? drivingRecord;
  final String? policeCheck;
  final String? passport;
  final String? vevoDetails;
  final String? englishCertificate;

  DriverDocumentsModel({
    this.identityVerificationImage,
    this.driverLicenseFront,
    this.driverLicenseBack,
    this.drivingRecord,
    this.policeCheck,
    this.passport,
    this.vevoDetails,
    this.englishCertificate,
  });

  static DriverDocumentsModel fromJson(Map<String, dynamic> json) {
    return DriverDocumentsModel(
      identityVerificationImage: json['identityVerificationImage'] as String?,
      driverLicenseFront: json['driverLicenseFront'] as String?,
      driverLicenseBack: json['driverLicenseBack'] as String?,
      drivingRecord: json['drivingRecord'] as String?,
      policeCheck: json['policeCheck'] as String?,
      passport: json['passport'] as String?,
      vevoDetails: json['vevoDetails'] as String?,
      englishCertificate: json['englishCertificate'] as String?,
    );
  }
}
