import 'package:untitled_sample_app/models/driver_vehicle_model.dart';

import '../base_response_model.dart';

class DriverVehicleResponse extends BaseResponseModel{
  final DriverVehicleModel? driverVehicleModel;

  DriverVehicleResponse({
    super.isSuccess,
    super.message,
    this.driverVehicleModel,
  });

   static DriverVehicleResponse fromJson(Map<String, dynamic> json) {
    return DriverVehicleResponse(
      isSuccess: json['isSuccess'],
      message: json['message'],
      driverVehicleModel: json['data'],
 );
  }
}
