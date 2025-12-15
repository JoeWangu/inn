import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/core/constants.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;
  final Dio dio;

  AuthInterceptor(this.ref, this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['requiresToken'] == 'false') {
      options.headers.remove('requiresToken');
      return handler.next(options);
    }

    final storage = ref.read(secureStorageProvider);
    final token = await storage.read(key: 'access_token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final storage = ref.read(secureStorageProvider);

      final refreshToken = await storage.read(key: 'refresh_token');

      if (refreshToken == null) {
        return handler.reject(err);
      }

      try {
        final refreshDio = Dio(
          BaseOptions(
            baseUrl: dio.options.baseUrl,
            headers: {'Content-Type': 'application/json'},
          ),
        );

        final response = await refreshDio.post(
          Constants.tokenRefreshEndpoint,
          data: {'refresh': refreshToken},
        );

        final newAccessToken = response.data['access'];
        final newRefreshToken = response.data['refresh'];

        await storage.write(key: 'access_token', value: newAccessToken);
        await storage.write(key: 'refresh_token', value: newRefreshToken);

        final opts = err.requestOptions;

        opts.headers['Authorization'] = 'Bearer $newAccessToken';

        final clonedRequest = await dio.fetch(opts);

        return handler.resolve(clonedRequest);
      } catch (e) {
        await storage.deleteAll();

        return handler.reject(err);
      }
    }

    handler.next(err);
  }
}
