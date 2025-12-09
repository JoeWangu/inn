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
        return "An unexpected network error occurred.";
    }
  }
  return "Something went wrong. Please try again.";
}

String _handleBadResponse(Response? response) {
  if (response == null) return "Unknown server error.";

  final statusCode = response.statusCode ?? 500;
  final data = response.data;

  // 1. Server Side Error (500s)
  if (statusCode >= 500) {
    return "Our servers are having trouble. Please try again later.";
  }

  // 2. Validation Errors (400, 409, 422)
  // We try to parse the specific JSON format: {"field": ["Error msg"]}
  if (data is Map<String, dynamic>) {
    try {
      final List<String> errorMessages = [];

      // Iterate through keys like 'email', 'username', 'password'
      data.forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          // If the server says "Email already exists", we can soften it if needed.
          // Or just show the first error for that field.
          final rawError = value.first.toString();
          
          // Optional: Sanitization logic to hide exact details if you prefer
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
        // Join them: "Email is unavailable. Username is unavailable."
        return errorMessages.join("\n"); 
      }
    } catch (_) {
      // Fallback if parsing fails
    }
  }

  // 3. Fallback for unparseable 4xx errors
  return "Invalid request. Please check your inputs.";
}