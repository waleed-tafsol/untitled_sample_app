import '../models/requests/driver_vehicle_request.dart';
import '../models/responses/driver_vehicle_response.dart';
import '../models/base_response_model.dart';
import 'api_base_helper.dart';
import '../utils/enums.dart';
import 'dart:convert';

class DriverVehicleService {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  /// Submit driver vehicle information
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> submitDriverVehicle(
    DriverVehicleRequest request,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverVehicle,
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
        message: 'Error submitting vehicle info: $e',
      );
    }
  }

  /// Update driver vehicle information
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> updateDriverVehicle(
    DriverVehicleRequest request,
    String driverId,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverVehicleUpdate,
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
        message: 'Error updating vehicle info: $e',
      );
    }
  }

  /// Get driver vehicle information
  /// Returns a DriverVehicleResponse with the driver's vehicle info
  Future<DriverVehicleResponse> getDriverVehicle(String driverId) async {
    final response = await _apiHelper.httpRequest(
      endPoint: EndPoints.driverVehicle,
      requestType: 'GET',
      requestBody: null,
      params: '/$driverId',
    );

    final parsed = json.decode(response.body);

    DriverVehicleResponse driverVehicleResponse =
        DriverVehicleResponse.fromJson(parsed);

    return driverVehicleResponse;
  }
}
