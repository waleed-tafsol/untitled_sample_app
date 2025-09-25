class DriverVehicleModel {
  final String? taxiPlate;
  final String? operatorName;
  final String? make;
  final String? model;
  final String? year;
  final String? color;
  final String? selectedVehicleType;
  final String? frontPlateImage;
  final String? rearPlateImage;
  final Map<String, String?>? requiredDocuments;
  final Map<String, String?>? additionalDocuments;

  DriverVehicleModel({
    this.taxiPlate,
    this.operatorName,
    this.make,
    this.model,
    this.year,
    this.color,
    this.selectedVehicleType,
    this.frontPlateImage,
    this.rearPlateImage,
    this.requiredDocuments,
    this.additionalDocuments,
  });

  static DriverVehicleModel fromJson(Map<String, dynamic> json) {
    return DriverVehicleModel(
      taxiPlate: json['taxiPlate'] as String?,
      operatorName: json['operatorName'] as String?,
      make: json['make'] as String?,
      model: json['model'] as String?,
      year: json['year'] as String?,
      color: json['color'] as String?,
      selectedVehicleType: json['selectedVehicleType'] as String?,
      frontPlateImage: json['frontPlateImage'] as String?,
      rearPlateImage: json['rearPlateImage'] as String?,
      requiredDocuments: json['requiredDocuments'] != null 
          ? Map<String, String?>.from(json['requiredDocuments']) 
          : null,
      additionalDocuments: json['additionalDocuments'] != null 
          ? Map<String, String?>.from(json['additionalDocuments']) 
          : null,
    );
  }
}
