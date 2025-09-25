
import 'package:untitled_sample_app/models/driver_documents_model.dart';

import '../base_response_model.dart';

class DriverDocumentsResponse extends BaseResponseModel{
  final DriverDocumentsModel? driverDocumentsModel;

  DriverDocumentsResponse({
    super.isSuccess,
    super.message,
    this.driverDocumentsModel,
  });

   static DriverDocumentsResponse fromJson(Map<String, dynamic> json) {
    return DriverDocumentsResponse(
      isSuccess: json['isSuccess'],
      message: json['message'],
      driverDocumentsModel: json['data'],
 );
  }
}
