import 'package:untitled_sample_app/models/driver_personal_info_model.dart';

import '../base_response_model.dart';

class DriverPersonalInfoResponse extends BaseResponseModel{
  final DriverPersonalInfoModel? driverPersonalInfoModel;

  DriverPersonalInfoResponse({
    super.isSuccess,
    super.message,
    this.driverPersonalInfoModel,
  });

   static DriverPersonalInfoResponse fromJson(Map<String, dynamic> json) {
    return DriverPersonalInfoResponse(
      isSuccess: json['isSuccess'],
      message: json['message'],
      driverPersonalInfoModel: json['data'],
 );
  }
}
