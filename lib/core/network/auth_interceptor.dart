import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/core/constants.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;
  final Dio dio;

  AuthInterceptor(this.ref, this.dio);

  // 1. OUTGOING: Add Token to Headers
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['requiresToken'] == 'false') {
      // If the flag exists, remove it (cleanup) and skip adding the token.
      options.headers.remove('requiresToken');
      return handler.next(options);
    }
    
    // We read the token from storage
    final storage = ref.read(secureStorageProvider);
    final token = await storage.read(key: 'access_token');

    // If we have a token, attach it
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  // 2. INCOMING: Handle Errors (401)
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the error is 401 Unauthorized or 403 Forbidden
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final storage = ref.read(secureStorageProvider);

      // A. Get the Refresh Token
      final refreshToken = await storage.read(key: 'refresh_token');

      if (refreshToken == null) {
        // No refresh token? We can't fix this. Logout.
        return handler.reject(err);
      }

      try {
        // B. Perform the Refresh
        // IMPORTANT: We create a NEW Dio instance just for this call.
        // If we used the main 'dio', it would trigger this Interceptor again
        // and cause an infinite loop!
        final refreshDio = Dio(
          BaseOptions(
            baseUrl: dio.options.baseUrl, // Use same base URL
            headers: {'Content-Type': 'application/json'},
          ),
        );

        // Call your backend's refresh endpoint
        // Verify this path matches your Django urls.py!
        final response = await refreshDio.post(
          Constants.tokenRefreshEndpoint,
          data: {'refresh': refreshToken},
        );

        // C. Extract the new Access Token
        // Django SimpleJWT usually returns: { "access": "...", "refresh": "..."}
        final newAccessToken = response.data['access']; 
        final newRefreshToken = response.data['refresh'];

        // D. Save it
        await storage.write(key: 'access_token', value: newAccessToken);
        await storage.write(key: 'refresh_token', value: newRefreshToken);

        // E. Retry the Original Request
        // We take the original failed request (err.requestOptions)
        final opts = err.requestOptions;

        // Update its header with the NEW token
        opts.headers['Authorization'] = 'Bearer $newAccessToken';

        // Clone the request and send it again
        final clonedRequest = await dio.fetch(opts);

        // Success! Resolve the original promise with this new result
        return handler.resolve(clonedRequest);
      } catch (e) {
        // F. Refresh failed? (e.g., Refresh token expired too)
        // The session is truly dead. Delete everything.
        await storage.deleteAll();

        // Reject the error so the UI shows "Session Expired" or redirects
        return handler.reject(err);
      }
    }

    // If it wasn't a 401, just pass the error along normally
    handler.next(err);
  }
}
