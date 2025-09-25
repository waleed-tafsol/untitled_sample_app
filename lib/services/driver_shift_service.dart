import '../models/requests/driver_shift_request.dart';
import '../models/responses/driver_shift_response.dart';
import '../models/base_response_model.dart';
import 'api_base_helper.dart';
import '../utils/enums.dart';
import 'dart:convert';

class DriverShiftService {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  /// Submit driver shift information
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> submitDriverShift(
    DriverShiftRequest request,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverShift,
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
        message: 'Error submitting shift info: $e',
      );
    }
  }

  /// Update driver shift information
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> updateDriverShift(
    DriverShiftRequest request,
    String driverId,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverShiftUpdate,
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
        message: 'Error updating shift info: $e',
      );
    }
  }

  /// Get driver shift information
  /// Returns a DriverShiftResponse with the driver's shift info
  Future<DriverShiftResponse> getDriverShift(String driverId) async {
    final response = await _apiHelper.httpRequest(
      endPoint: EndPoints.driverShift,
      requestType: 'GET',
      requestBody: null,
      params: '/$driverId',
    );

    final parsed = json.decode(response.body);

    DriverShiftResponse driverShiftResponse =
        DriverShiftResponse.fromJson(parsed);

    return driverShiftResponse;
  }
}
