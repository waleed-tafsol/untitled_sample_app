import 'dart:convert';

import 'package:untitled_sample_app/models/responses/driver_personal_info_response.dart';

import '../models/requests/driver_personal_info_request.dart';
import '../models/base_response_model.dart';
import 'api_base_helper.dart';
import '../utils/enums.dart';

class DriverPersonalInfoService {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  /// Submit driver personal information
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> submitDriverPersonalInfo(
    DriverPersonalInfoRequest request,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverPersonalInfo,
        requestType: 'POST',
        requestBody: requestBody,
        params: '',
      );

      // Parse response
      if (response != null) {
        return BaseResponseModel.fromJson(response);
      } else {
        return BaseResponseModel(
          isSuccess: false,
          message: 'No response from server',
        );
      }
    } catch (e) {
      return BaseResponseModel(
        isSuccess: false,
        message: 'Error submitting personal info: $e',
      );
    }
  }

  /// Update driver personal information
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> updateDriverPersonalInfo(
    DriverPersonalInfoRequest request,
    String driverId,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverPersonalInfoUpdate,
        requestType: 'PUT',
        requestBody: requestBody,
        params: '/$driverId',
      );

      // Parse response
      if (response != null) {
        return BaseResponseModel.fromJson(response);
      } else {
        return BaseResponseModel(
          isSuccess: false,
          message: 'No response from server',
        );
      }
    } catch (e) {
      return BaseResponseModel(
        isSuccess: false,
        message: 'Error updating personal info: $e',
      );
    }
  }

  Future<DriverPersonalInfoResponse> getDriverPersonalInfo(
    String driverId,
  ) async {
    final response = await _apiHelper.httpRequest(
      endPoint: EndPoints.driverPersonalInfo,
      requestType: 'GET',
      requestBody: null,
      params: '/$driverId',
    );

    final parsed = json.decode(response.body);

    DriverPersonalInfoResponse driverPersonalInfoResponse =
        DriverPersonalInfoResponse.fromJson(parsed);

    return driverPersonalInfoResponse;
  }
}
