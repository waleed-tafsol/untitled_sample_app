class DriverVehicleRequest {
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

  DriverVehicleRequest({
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

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'taxiPlate': taxiPlate,
      'operatorName': operatorName,
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'selectedVehicleType': selectedVehicleType,
      'frontPlateImage': frontPlateImage,
      'rearPlateImage': rearPlateImage,
      'requiredDocuments': requiredDocuments,
      'additionalDocuments': additionalDocuments,
    };
  }
}
