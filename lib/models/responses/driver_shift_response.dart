import 'package:untitled_sample_app/models/driver_shift_model.dart';

import '../base_response_model.dart';

class DriverShiftResponse extends BaseResponseModel{
  final DriverShiftModel? driverShiftModel;

  DriverShiftResponse({
    super.isSuccess,
    super.message,
    this.driverShiftModel,
  });

   static DriverShiftResponse fromJson(Map<String, dynamic> json) {
    return DriverShiftResponse(
      isSuccess: json['isSuccess'],
      message: json['message'],
      driverShiftModel: json['data'],
 );
  }
}
