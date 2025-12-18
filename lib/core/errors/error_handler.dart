import 'package:dio/dio.dart';

String getReadableError(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return "Connection timeout. Please check your internet connection.";

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return "Request cancelled.";

      default:
        return "Network error. Please check your connection.";
    }
  }
  return "Something went wrong. Please try again.";
}

String _handleBadResponse(Response? response) {
  if (response == null) return "Unknown server error.";

  final statusCode = response.statusCode ?? 500;
  final data = response.data;

  if (statusCode >= 500) {
    return "Our servers are having trouble. Please try again later.";
  }

  if (data is Map<String, dynamic>) {
    if (data.containsKey('detail')) {
      final detail = data['detail'];

      if (data['code'] == 'token_not_valid') {
        return "Your session has expired. Please log in again.";
      }

      return detail.toString();
    }

    try {
      final List<String> errorMessages = [];

      data.forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          final rawError = value.first.toString();

          if (rawError.contains("already exists")) {
            errorMessages.add("$key is unavailable.");
          } else {
            errorMessages.add(rawError);
          }
        } else if (value is String) {
          errorMessages.add(value);
        }
      });

      if (errorMessages.isNotEmpty) {
        return errorMessages.join("\n");
      }
    } catch (_) {}
  }

  return "Invalid request. Please check your inputs.";
}
