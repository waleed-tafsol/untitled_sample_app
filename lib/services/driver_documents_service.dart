import '../models/requests/driver_documents_request.dart';
import '../models/responses/driver_documents_response.dart';
import '../models/base_response_model.dart';
import 'api_base_helper.dart';
import '../utils/enums.dart';
import 'dart:convert';

class DriverDocumentsService {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  /// Submit driver documents
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> submitDriverDocuments(
    DriverDocumentsRequest request,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverDocuments,
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
        message: 'Error submitting documents: $e',
      );
    }
  }

  /// Update driver documents
  /// Returns a BaseResponseModel with the API response
  Future<BaseResponseModel> updateDriverDocuments(
    DriverDocumentsRequest request,
    String driverId,
  ) async {
    try {
      // Convert request to JSON
      final requestBody = request.toJson();

      // Make API call
      final response = await _apiHelper.httpRequest(
        endPoint: EndPoints.driverDocumentsUpdate,
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
        message: 'Error updating documents: $e',
      );
    }
  }

  /// Get driver documents
  /// Returns a DriverDocumentsResponse with the driver's documents
  Future<DriverDocumentsResponse> getDriverDocuments(String driverId) async {
    final response = await _apiHelper.httpRequest(
      endPoint: EndPoints.driverDocuments,
      requestType: 'GET',
      requestBody: null,
      params: '/$driverId',
    );

    final parsed = json.decode(response.body);

    DriverDocumentsResponse driverDocumentsResponse =
        DriverDocumentsResponse.fromJson(parsed);

    return driverDocumentsResponse;
  }
}
